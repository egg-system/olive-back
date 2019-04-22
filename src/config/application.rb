require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Src
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    
    config.time_zone = 'Tokyo'
    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.active_record.default_timezone = :local

    # feからのアクセス設定
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV.fetch('RESERVATION_CLIENT_DOMAIN', '')
    
        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          expose: ['uid', 'access-token', 'client']
      end
    end
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
