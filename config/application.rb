require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Enabling garbage collection instrumentation
GC::Profiler.enable

module MalvadosFeed
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Content Compression via Rack::Deflater
    config.middleware.use Rack::Deflater

    # configure lograge
    config.lograge.enabled = true
    config.lograge.custom_options = -> (event) do
      params = event.payload[:params]
        .except('controller', 'action', 'format')

      params.tap do |p|
        p[:uuid] = event.payload[:uuid]
      end
    end

    # rspec config and generators
    config.generators do |g|
      g.fixture_replacement :factory_girl,
        dir: 'spec/factories'

      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
    end
  end
end
