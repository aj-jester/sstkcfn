module SstkCfn
  module Error
    class BaseError < StandardError
      def initialize msg = 'Base Error'
        super
      end
    end

    class ConfigENOENT < BaseError; end
    class DslENOENT < BaseError; end
    class StackName < BaseError; end
    class TemplateSize < BaseError; end
  end
end
