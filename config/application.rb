require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module G360EventApplication
    # Configure the application
    class Application < Rails::Application
        config.i18n.enforce_available_locales = true

        config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
        config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
        config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
        config.assets.precompile += %w( .svg .eot .woff .ttf )

        ActsAsTaggableOn.remove_unused_tags
    end
end
