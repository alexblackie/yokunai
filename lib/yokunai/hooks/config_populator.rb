module Yokunai
  module Hooks
    class ConfigPopulator

      # Seed the configuration class on boot.
      def self.run
        Yokunai::Config.populate(ENV["YOKUNAI_ENV"] || "development")
      end

    end
  end
end
