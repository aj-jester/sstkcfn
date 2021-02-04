module SstkCfn::Tasks
  module DeleteStack
    def self.run
      SstkCfn::AWS.connect.delete_stack({
        stack_name: SstkCfn::Helper.stack_name
      })
    end
  end
end
