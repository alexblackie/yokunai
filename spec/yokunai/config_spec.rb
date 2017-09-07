require "spec_helper"

RSpec.describe Yokunai::Config do
  context "with a YAML config" do
    before do
      Yokunai::Config.populate
    end

    describe ".get" do
      it "fetches from the YAML config" do
        expect(Yokunai::Config.get("some_key")).to eq "get me"
      end

      it "merges the defaults" do
        expect(Yokunai::Config.get("asset_dir")).to eq "web/assets"
      end

      it "returns nil for unknown keys" do
        expect(Yokunai::Config.get("this_is_not_a_key")).to be_nil
      end
    end
  end

  describe ".set" do
    let!(:some_object) { Object.new }

    before do
      Yokunai::Config.set("dynamic_key", some_object)
    end

    it "sets the key given" do
      expect(Yokunai::Config.get("dynamic_key")).to eq some_object
    end

    it "isn't persisted" do
      Yokunai::Config.populate
      expect(Yokunai::Config.get("dynamic_key")).to be_nil
    end
  end

  context "default" do
    before do
      Yokunai::Config.populate("not_a_file")
    end

    describe ".get" do
      it "populates the defaults" do
        expect(Yokunai::Config.get("template_dir")).to eq "web/views"
      end
    end
  end
end
