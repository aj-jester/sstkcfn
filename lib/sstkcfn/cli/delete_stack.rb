module SstkCfn::Cli
  module DeleteStack
    def self.command
      @cmd ||= Cri::Command.define do
        name 'delete-stack'
        usage 'delete-stack [options]'
        description 'Delete AWS CloudFormation stack.'
        summary 'Delete existing stack.'

        run do |opts, args, cmd|
          SstkCfn::Opts.cli opts
          SstkCfn::Tasks::DeleteStack.run
        end

      end
    end
  end
  self.command.add_command DeleteStack.command
end
