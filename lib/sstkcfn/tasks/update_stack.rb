module SstkCfn::Tasks
  module UpdateStack
    def self.run
      begin
        stack_name = SstkCfn::Helper.stack_name

        resp = SstkCfn::AWS.connect.update_stack({
          stack_name: stack_name,
          template_body: SstkCfn::Template.generate,
          capabilities: ["CAPABILITY_IAM"],
          tags: [
            {
              key: "StackName",
              value: stack_name,
            },
          ],
        })
      end
    rescue Aws::CloudFormation::Errors::ValidationError => e
      puts e.message
    end
  end
end
