require 'json'
require 'yaml'
require 'ostruct'

module SstkCfn
  module Config
    def self.get
      if @config.nil?

        config_file = [

          # Config loads in this order
          '/etc/sstkcfn.yaml',
          "#{ENV['HOME']}/sstkcfn.yaml",
          "#{ENV['HOME']}/.sstkcfn.yaml",

        ].select { |config| File.file? config }.first

        if config_file.nil?
          raise SstkCfn::Error::ConfigENOENT, 'Config file not found'
        end

        # You might be wondering why we are converting YAML -> JSON -> Struct and not YAML -> Struct.
        # Converting YAML -> Struct doesn't convert nested keys into objects.
        # Conveting it to JSON converts these nested keys into objects.
        @config = JSON.parse(
          YAML.load_file(config_file).to_json,
          object_class: OpenStruct
        )
      end

      @config
    end    
  end
end
