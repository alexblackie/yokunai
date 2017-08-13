module FakeApp
  class HomeController < Yokunai::AbstractController

    def get
      respond body: "it werks"
    end

    def post
      respond body: "hello #{request.params['name']}", code: 201
    end

  end
end
