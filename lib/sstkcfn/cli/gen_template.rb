module SstkCfn::Cli
  module GenTemplate
    def self.command
      @cmd ||= Cri::Command.define do
        name 'gen-template'
        usage 'gen-template [options]'
        description 'Generate and output AWS CloudFormation template.'
        summary 'Generate and output CFN template.'

        run do |opts, args, cmd|
          SstkCfn::Opts.cli opts
          SstkCfn::Tasks::GenTemplate.run
        end

      end
    end
  end
  self.command.add_command GenTemplate.command
end
