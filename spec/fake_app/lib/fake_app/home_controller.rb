module FakeApp
  class HomeController < Yokunai::AbstractController
    def get
      respond body: "damn right"
    end
  end
end
