module SstkCfn::Cli
  module GenFragment
    def self.command
      @cmd ||= Cri::Command.define do
        name 'gen-fragment'
        usage 'gen-fragment [options]'
        description 'Generate a fragmented AWS CloudFormation template.'
        summary 'Generate a fragmented CFN template.'

        run do |opts, args, cmd|
          SstkCfn::Opts.cli opts
          SstkCfn::Tasks::GenFragment.run
        end

      end
    end
  end
  self.command.add_command GenFragment.command
end
