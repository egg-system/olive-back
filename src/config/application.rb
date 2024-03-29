require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Src
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = :ja

    config.time_zone = 'Tokyo'
    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.active_record.default_timezone = :local

    # feからのアクセス設定
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV.fetch('RESERVATION_CLIENT_DOMAIN', 'http://localhost:3000')

        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          expose: ['uid', 'access-token', 'client']
      end
    end

    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      port: ENV.fetch('MAIL_PORT', ''),
      domain: ENV.fetch('MAIL_DOMAIN', ''),
      address: ENV.fetch('MAIL_HOST', ''),
      user_name: ENV.fetch('MAIL_USER', ''),
      password: ENV.fetch('MAIL_PASSWORD', ''),
      authentication: ENV.fetch('MAIL_AUTH', 'login').to_sym,
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
