module SstkCfn::Cli
  module CreateStack
    def self.command
      @cmd ||= Cri::Command.define do
        name 'create-stack'
        usage 'create-stack [options]'
        description 'Create AWS CloudFormation stack.'
        summary 'Create a new stack.'

        run do |opts, args, cmd|
          SstkCfn::Opts.cli opts
          SstkCfn::Tasks::CreateStack.run
        end

      end
    end
  end
  self.command.add_command CreateStack.command
end
