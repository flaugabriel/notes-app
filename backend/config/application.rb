require_relative "boot"

require "rails/all"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 8.0
    config.i18n.available_locales = :'pt-BR'
    config.i18n.default_locale = :'pt-BR'
    # ✅ REGISTRA BLUEPRINTS
    config.autoload_paths << Rails.root.join('app/blueprints')
    config.eager_load_paths << Rails.root.join('app/blueprints')
    config.autoload_lib(ignore: %w[assets tasks])

    config.api_only = true

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
  end
end
