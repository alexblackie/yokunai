module FakeApp
  ROUTES = {
    %r{^/$} => { class: "FakeApp::HomeController", methods: %w[GET POST] },
    %r{^/assets/(?<name>.+)$} => { class: "Yokunai::StaticController", methods: ["GET"] }
  }.freeze

  BASE_DIR = File.join(File.dirname(__FILE__), "..", "..").freeze
end
