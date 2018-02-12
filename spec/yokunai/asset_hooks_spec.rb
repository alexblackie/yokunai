require "spec_helper"

RSpec.describe "Static Asset Processing", type: :request do

  it "runs the processor on the asset" do
    get("/assets/site.css")
    expect(last_response.body).to include("BODY {")
  end

end
