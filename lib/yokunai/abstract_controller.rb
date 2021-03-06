module Yokunai
  class AbstractController

    # --------------------------------------------------------------------------
    # Constants
    # --------------------------------------------------------------------------

    DEFAULT_HEADERS = {
      "Content-Type" => "text/html"
    }.freeze

    # --------------------------------------------------------------------------
    # Instance Methods
    # --------------------------------------------------------------------------

    # @param env [Rack::Env] The Rack ENV
    # @param captures [MatchData] The named captures from the route regex
    def initialize(env, captures = nil)
      @env = env
      @captures = captures
      @templates = Yokunai::Template.new
    end

    # --------------------------------------------------------------------------
    # Default HTTP method handlers
    # --------------------------------------------------------------------------

    def get
      unsupported_method
    end

    def post
      unsupported_method
    end

    def put
      unsupported_method
    end

    def patch
      unsupported_method
    end

    def delete
      unsupported_method
    end

    def options
      unsupported_method
    end

    private

    def respond(code: 200, headers: {}, body: "", template: nil, context: {})
      if template
        return respond_error(:not_found) unless @templates.exist?(template)
        body = @templates.render(template, context)
      end

      [
        code,
        DEFAULT_HEADERS.merge(headers),
        [body]
      ]
    end

    def respond_error(meth)
      Yokunai::ErrorsController.new(@env).public_send(meth)
    end

    def unsupported_method
      [405, {}, ["Error 405: Method not supported on this resource.\n"]]
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

  end
end
