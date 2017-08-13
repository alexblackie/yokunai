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
