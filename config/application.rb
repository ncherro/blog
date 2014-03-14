require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Blog
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'

    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = false
  end
end
