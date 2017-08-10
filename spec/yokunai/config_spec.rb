require "spec_helper"

RSpec.describe Yokunai::Config do

  before do
    Yokunai::Config.base_dir = FakeApp::BASE_DIR
    Yokunai::Config.populate
  end

  describe ".get" do
    it "fetches from the YAML config" do
      expect(Yokunai::Config.get("some_key")).to eq "get me"
    end

    it "returns nil for unknown keys" do
      expect(Yokunai::Config.get("this_is_not_a_key")).to be_nil
    end
  end

end
