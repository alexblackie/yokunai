require "spec_helper"

RSpec.describe Yokunai::AbstractController, type: :request do
  # While this test is for "AbstractController", this is tested through the
  # concrete implementation, "FakeApp::HomeController".

  describe "#get with params" do
    before do
      post("/", name: "bobby")
    end

    it "can parse the params" do
      expect(last_response.body).to eq "hello bobby"
    end
  end
end
