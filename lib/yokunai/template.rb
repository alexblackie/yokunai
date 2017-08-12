module Yokunai
  # Renders ERB templates.
  class Template

    FALLBACK_EMPTY_LAYOUT = "<%= partial %>".freeze

    def initialize(template_path: nil)
      template_dir = File.join(Yokunai::Config.base_dir, Yokunai::Config.get("template_dir"))
      @template_path = template_path || template_dir
      @raw_layout = get_layout
    end

    # Render an ERB template with the given name, and cache the result for
    # subsequent calls.
    #
    # @param template [String] the name of a template
    # @param context [Hash] key/value pairs of variables to bind the template
    # @return [String] the ERB render result
    def render(template, context = {})
      return nil unless exist?(template)

      path = File.join(@template_path, template + ".erb")
      layout_context = context.merge({
        partial: ERB.new(File.read(path)).result(Yokunai::RenderContext.new(context).get_binding)
      })

      ERB.new(@raw_layout).result(Yokunai::RenderContext.new(layout_context).get_binding)
    end

    # Checks if a template exists. Useful for gating before rendering.
    #
    # @param template [String] the template name
    # @return [Boolean]
    def exist?(template)
      File.exist?(File.join(@template_path, template + ".erb"))
    end

    private

    def get_layout
      layout_path = File.join(@template_path, "layout.erb")
      if File.exist?(layout_path)
        File.read(layout_path)
      else
        FALLBACK_EMPTY_LAYOUT
      end
    end

  end
end
