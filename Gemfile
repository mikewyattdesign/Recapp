source 'https://rubygems.org'
ruby '2.1.2'

gem 'unicorn'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Error monitoring service
gem 'rollbar', '0.12.17'

# Application monitoring service
gem 'newrelic_rpm', '3.8.1.221'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use bootstrap for styling
gem 'bootstrap-sass', '~> 3.1.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Turbolinks also makes you mad when event binding doesn't work as expected
gem 'jquery-turbolinks', '2.0.2'

# Add devise for user authentication
gem 'devise', '3.2.2'

# Add cancancan for authorization
gem 'cancancan', '1.7.1'

# Use paperclip for photo attachment
gem 'paperclip', '4.0.0'

# Use paperclip-ffmpeg for video handling
gem 'paperclip-ffmpeg', '1.0.1'

# Use remotipart for remote file uploads
gem 'remotipart', '1.2.1'

# Use Amazon S3 for production file storage
gem 'aws-sdk', '1.33.0'

# Direct Upload to S3
gem 's3_direct_upload', '0.1.7'

# Use Delayed Job for background processing
gem 'delayed_job_active_record', '4.0.1'

# Use acts-as-taggable-on for tagging
gem 'acts-as-taggable-on', '3.0.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# XML parser, added to prevent build breaking on Mavericks
gem 'nokogiri', '1.6.1'

group :development, :test do
    # Add testing via rspec
    gem 'rspec-rails', '2.14.0'

    # Use fuubar to style rspec output
    gem 'fuubar', '1.3.2'

    # Add guard to auto-test
    gem 'guard-rspec', '3.0.2'

    # add terminal notifier to see guard results
    gem 'terminal-notifier-guard', '1.5.3'

    # Use FactoryGirl to create stubs, test models, etc
    gem 'factory_girl_rails', '4.4.0'

    # add better errors
    gem 'better_errors', '0.9.0'
    gem 'binding_of_caller', '0.7.2'

    # add sprockets better errors
    gem 'sprockets_better_errors', '0.0.4'

    # add RailsPanel Chrome Extension
    gem 'meta_request', '0.3.0'

    # Use hologram to create style guide
    gem 'hologram', github: 'trulia/hologram'

    gem 'guard-hologram', require: false

    gem 'sqlite3'
end

group :development do
    # Use daemons for delayed job in development
    gem 'daemons', '1.1.9'
end

group :test do
    # Use faker for fake data generation
    gem 'faker', '~> 1.1.2'

    # Use Capybara for functional testing
    gem 'capybara', '2.2.1'

    # Use database cleaner to (predictably) clean the db after tests
    gem 'database_cleaner', '~> 1.0.1'

    # Use launchy to view web results of integration tests
    gem 'launchy', '~> 2.3.0'

    # Make selenium test driver available
    gem 'selenium-webdriver', '~> 2.39.0'
end

group :production do
    # Use postgresql as the database for Active Record
    gem 'pg'
    gem 'rails_12factor'

    gem 'heroku'
end

group :doc do
    # bundle exec rake doc:rails generates the API under doc/api.
    gem 'sdoc', require: false
end
