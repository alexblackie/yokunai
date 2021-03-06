module Yokunai
  # The Rack-compatible entrypoint class. Acts as the router, sending the
  # request to the appropriate controller for handling.
  class Application

    # List of default hooks we run on app boot to set up the framework itself.
    DEFAULT_HOOKS = [
      Yokunai::Hooks::ConfigPopulator
    ].freeze

    # @param route_map [Hash] A hash with path regexes as keys, and hashes as values with the controller to send matching requests to.
    # @param base_dir [String] The absolute base directory to use for various lookups.
    # @param hooks [Array] An optional list of classes which will have their class-level `run` method called when the app boots.
    def initialize(route_map:, base_dir:, hooks: [])
      @routes = route_map
      Yokunai::Config.base_dir = base_dir
      (DEFAULT_HOOKS + hooks).each(&:run)
    end

    # Route a request to the correct controller based on the given data.
    #
    # @param env [Rack::Env] the full Rack environment
    # @return [Array] a Rack-compatible response array.
    def call(env)
      route = @routes.map do |exp, meta|
        next unless matches = env["PATH_INFO"].match(exp)
        meta.merge(captures: matches)
      end.compact.first

      return Yokunai::ErrorsController.new(env).not_found unless route

      request_method = env["REQUEST_METHOD"]
      if route[:methods].include?(request_method)
        Object.const_get(route[:class])
          .new(env, route[:captures])
          .public_send(request_method.downcase)
      else
        Yokunai::ErrorsController.new(env).unsupported_method
      end
    end

  end
end
