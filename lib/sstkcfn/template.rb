require 'json'
require 'cfndsl'
require 'tempfile'

module SstkCfn
  module Template
    def self.generate fragment = false

      dsl_dir = fragment ? 'dsl/fragments' : 'dsl'

      # Initialize here so invalid env and name are caught early on
      stack_name = SstkCfn::Helper.stack_name

      # DSL file is needed to generate the template, of course.
      dsl_file = "#{SstkCfn::Config.get.template.stack_dir}/#{dsl_dir}/#{SstkCfn::Opts.cli.name}.rb"

      unless File.file? dsl_file
        raise SstkCfn::Error::DslENOENT, "DSL file not found #{dsl_file}"
      end

      # Pass all CLI options and some config to base params
      base_params = SstkCfn::Helper.deep_merge(
        SstkCfn::Helper.deep_merge(SstkCfn::Helper.load_params('env/base'), {opts: SstkCfn::Opts.cli.to_h}),
        {
          stack_dir: SstkCfn::Config.get.template.stack_dir,
          stack_name: stack_name,
        }
      )

      stack_params = SstkCfn::Helper.deep_merge(
        SstkCfn::Helper.deep_merge(base_params, SstkCfn::Helper.load_params("env/#{SstkCfn::Opts.cli.env}")),
        SstkCfn::Helper.load_params(SstkCfn::Opts.cli.name)
      )

      Tempfile.create([stack_name, '.yaml']) do |file|
        file.write stack_params.to_yaml
        file.rewind

        # Calling CfnDsl
        generated_template = CfnDsl::eval_file_with_extras(dsl_file, [[:yaml, file.path]], STDOUT).to_json

        # AWS limits the size (bytes) of template body
        template_size = generated_template.bytesize
        if template_size > SstkCfn::Config.get.template.max_bytesize
          raise SstkCfn::Error::TemplateSize,
            "Template size exceeded (Max: #{SstkCfn::Config.get.template.max_bytesize}B, Actual: #{template_size}B)."
        end

        generated_template
      end

    end    
  end
end
