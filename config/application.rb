require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ravn
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Use routes for 404, 500, and other errors.
    config.exceptions_app = routes

    config.autoload_paths << "#{root}/app/views"
    config.autoload_paths << "#{root}/app/views/layouts"
    config.autoload_paths << "#{root}/app/views/components"
    # :nocov:
    Dir["packs/*/app/views/components"].each do |path|
      config.autoload_paths << path
    end
    # :nocov:

    # Override avo.autoload initializer to ensure packs/admin/app/avo/resources
    # are successfully loaded.
    config.before_configuration do
      Avo::Engine.initializers.delete_if { _1.name == "avo.autoload" }
      avo_directory = Rails.root.join("packs", "admin", "app", "avo").to_s
      Rails.autoloaders.main.push_dir(avo_directory, namespace: Avo)
      config.watchable_dirs[avo_directory] = [:rb]
    end
  end
end
