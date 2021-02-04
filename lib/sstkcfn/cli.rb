require 'cri'

module SstkCfn
  module Cli
    def self.command
      @cmd ||= Cri::Command.define do
        name 'sstkcfn'
        usage 'sstkcfn <command> [options]'
        summary 'Shutterstock CfnDsl helper.'
        description <<-DESC
        Making it easy to interact with CfnDsl to
        launch AWS CFN stacks.
        DESC

        required :e, :env, "Stack environment", :arguemnt => :required
        required :n, :name, "Stack name", :arguemnt => :required

        flag :h, :help, 'Show this message' do |value, cmd|
          puts cmd.help
          exit 0
        end

        run do |opts, args, cmd|
          puts cmd.help :verbose => true
        end
      end
    end
  end
end

require 'cli/create_stack'
require 'cli/delete_stack'
require 'cli/gen_fragment'
require 'cli/gen_template'
require 'cli/stack_events'
require 'cli/update_stack'
