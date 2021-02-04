module SstkCfn
  module Helper

    def self.stack_name
      if SstkCfn::Opts.cli.env.empty? or SstkCfn::Opts.cli.name.empty?
        raise SstkCfn::Error::StackName, 'Environment and Name cannot be empty.'
      end
 
      if SstkCfn::Opts.cli.env !~ /^[a-zA-Z0-9\-?]*$/ or SstkCfn::Opts.cli.name !~ /^[a-zA-Z0-9\-?]*$/
        raise SstkCfn::Error::StackName,
          'Only alphanumeric and hyphen allowed for Environment and Name.'
      end

      "#{SstkCfn::Opts.cli.env}-#{SstkCfn::Opts.cli.name}"
    end

    def self.deep_merge merge_into, merge_from
      merge_into.merge(merge_from) do |key, into, from|
        if from.respond_to?(:blank) && from.blank?
          into
        elsif into.kind_of?(Hash) and from.kind_of?(Hash)
          self.deep_merge(into, from)
        elsif into.kind_of?(Array) and from.kind_of?(Array)
          into.concat(from).uniq
        else
          from
        end
      end
    end

    def self.load_params file_name
      begin
        YAML.load_file "#{SstkCfn::Config.get.template.stack_dir}/params/#{file_name}.yaml"
      rescue Errno::ENOENT
        Hash.new
      end
    end

  end
end
