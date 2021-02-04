module SstkCfn::Cli
  module UpdateStack
    def self.command
      @cmd ||= Cri::Command.define do
        name 'update-stack'
        usage 'update-stack [options]'
        description 'Update AWS CloudFormation stack.'
        summary 'Update existing stack.'

        run do |opts, args, cmd|
          SstkCfn::Opts.cli opts
          SstkCfn::Tasks::UpdateStack.run
        end

      end
    end
  end
  self.command.add_command UpdateStack.command
end
