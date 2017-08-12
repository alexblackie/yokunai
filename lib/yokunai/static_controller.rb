module Yokunai
  class StaticController < AbstractController

    DEFAULT_ASSETS_DIR = "web/assets".freeze

    def get
      dirname = Yokunai::Config.get("asset_dir") || DEFAULT_ASSETS_DIR
      asset_dir = File.join(Yokunai::Config.base_dir, dirname)
      asset_file = File.join(asset_dir, @captures[:name])

      if File.exist?(asset_file)
        mime = Yokunai::Mime.detect_from_path(asset_file)
        asset_body = File.read(asset_file)

        respond(body: asset_body, headers: {"Content-Type" => mime})
      else
        respond_error(:not_found)
      end
    end

  end
end
