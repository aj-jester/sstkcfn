module SstkCfn::Tasks
  module GenFragment
    def self.run
      SstkCfn::Template.generate true
    end
  end
end
