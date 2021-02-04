module SstkCfn::Tasks
  module CreateStack
    def self.run
      begin
        stack_name = SstkCfn::Helper.stack_name

        resp = SstkCfn::AWS.connect.create_stack({
          stack_name: stack_name,
          template_body: SstkCfn::Template.generate,
          timeout_in_minutes: 10,
          capabilities: ["CAPABILITY_IAM"],
          tags: [
            {
              key: "StackName",
              value: stack_name,
            },
          ],
        })
      end
    rescue Aws::CloudFormation::Errors::AlreadyExistsException => e
      puts "#{e.message}, try updating instead."
    end
  end
end
