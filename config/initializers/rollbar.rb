require 'rollbar/rails'
Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

    # Here we'll disable in 'test':
    config.enabled = false if Rails.env.test?
end
