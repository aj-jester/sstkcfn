require 'text-table'

module SstkCfn::Tasks
  module StackEvents
    def self.run
      begin
        stack_name = SstkCfn::Helper.stack_name

        resp = SstkCfn::AWS.connect.describe_stack_events({
          stack_name: stack_name
        })
        stack_events = resp.stack_events.reverse

        until resp.next_token.nil?
          resp = SstkCfn::AWS.connect.describe_stack_events({
            stack_name: stack_name,
            next_token: resp.next_token,
          })
          stack_events += resp.stack_events.reverse
        end

        stack_events.map! do |event|
          [
            event.timestamp,
            event.resource_status,
            event.resource_type,
            event.logical_resource_id,
            event.resource_status_reason,
          ]
        end

        # Add heading to the top of array
        stack_events.unshift([
          'Timestamp', 'Status', 'Type', 'Logical ID', 'Status reason',
        ])

        # Build a pretty table
        puts stack_events.to_table(:first_row_is_head => true)

      rescue Aws::CloudFormation::Errors::ValidationError => e
        puts e.message
      end
    end
  end
end
