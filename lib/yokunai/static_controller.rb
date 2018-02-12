module Yokunai
  class StaticController < AbstractController

    def get
      asset_dir = File.join(Yokunai::Config.base_dir, Yokunai::Config.get("asset_dir"))
      asset_hooks = Yokunai::Config.get("asset_hooks")
      asset_file = File.join(asset_dir, @captures[:name])

      if File.exist?(asset_file)
        mime = Yokunai::Mime.detect_from_path(asset_file)
        asset_body = File.read(asset_file)
        if processor = asset_hooks[mime]
          asset_body = Object.
            const_get(processor).
            public_send(:process, asset_body)
        end

        respond(body: asset_body, headers: { "Content-Type" => mime })
      else
        respond_error(:not_found)
      end
    end

  end
end
