require 'aws-sdk'

module SstkCfn
  module AWS
    def self.connect
      @client = Aws::CloudFormation::Client.new(
        access_key_id: SstkCfn::Config.get.aws.access_key_id,
        secret_access_key: SstkCfn::Config.get.aws.secret_access_key,
        region: SstkCfn::Config.get.aws.region
      )
    end
  end
end
