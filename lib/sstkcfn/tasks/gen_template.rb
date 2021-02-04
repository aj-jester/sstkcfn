module SstkCfn::Tasks
  module GenTemplate
    def self.run
      puts JSON.pretty_generate JSON.parse SstkCfn::Template.generate
    end
  end
end
