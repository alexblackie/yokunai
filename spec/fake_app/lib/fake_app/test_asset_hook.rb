module FakeApp
  class TestAssetHook

    def self.process(body)
      body.upcase
    end

  end
end
