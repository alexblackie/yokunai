require "spec_helper"

RSpec.describe "Boot Hooks" do
  subject do
    Yokunai::Application.new(
      route_map: [],
      base_dir: FakeApp::BASE_DIR,
      hooks: [FakeApp::TestHook]
    )
  end

  it "runs the hooks" do
    expect(FakeApp::TestHook).to receive(:run)
    subject
  end
end
