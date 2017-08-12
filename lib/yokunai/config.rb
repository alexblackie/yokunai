module Yokunai
  # A centralized way to get configuration options. Reads values out of
  # `config.yml` (or whatever name is passed to `populate`).
  class Config

    # Any key in this hash can be overridden in your app's `config/*.yml`.
    DEFAULT_CONFIGURATION = {
      "template_dir" => "web/views",
      "asset_dir" => "web/assets"
    }.freeze

    # Set the base directory path.
    #
    # @param base_dir [String]
    # @return [String]
    def self.base_dir=(dir)
      @@base_dir = dir
    end

    # Get the base directory path.
    #
    # @return [String]
    def self.base_dir
      @@base_dir
    end

    # Loads the config into memory from disk. Called automatically on the first
    # cold-get, but can be called manually to warm up.
    #
    # @param name [String] the name of the confg file to load. If not provided,
    #                      will use the value of YOKUNAI_ENV.
    def self.populate(name = nil)
      name ||= ENV["YOKUNAI_ENV"]
      config_path = File.join(@@base_dir, "config", "#{name}.yml")
      user_config = File.exist?(config_path) ? YAML.load_file(config_path) : {}

      @@config = DEFAULT_CONFIGURATION.merge(user_config)
    end

    # Get the value of a config option
    #
    # @param key [String] the key to fetch
    # @return [any] whatever key contains
    def self.get(key)
      populate unless class_variable_defined?(:@@config)
      @@config[key]
    end

  end
end
