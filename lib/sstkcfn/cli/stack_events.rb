module SstkCfn::Cli
  module StackEvents
    def self.command
      @cmd ||= Cri::Command.define do
        name 'stack-events'
        usage 'stack-events [options]'
        description 'Describe CloudFormation stack events.'
        summary 'Describe stack events.'

        run do |opts, args, cmd|
          SstkCfn::Opts.cli opts
          SstkCfn::Tasks::StackEvents.run
        end

      end
    end
  end
  self.command.add_command StackEvents.command
end
