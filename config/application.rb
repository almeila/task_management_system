require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups)

module ElTraining
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    ActiveRecord::Base.protected_environments = %w(production staging)
  end
end
