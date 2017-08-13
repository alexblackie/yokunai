# Dependencies
require "mimemagic"
require "ostruct"
require "yaml"

# Setup
require "yokunai/version"
require "yokunai/config"

# Boot hooks
require "yokunai/hooks/config_populator"

# Core
require "yokunai/application"
require "yokunai/render_context"
require "yokunai/template"
require "yokunai/mime"

# Controllers
require "yokunai/abstract_controller"
require "yokunai/errors_controller"
require "yokunai/static_controller"
