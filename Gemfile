source 'https://rubygems.org'
ruby '2.1.0'

gem 'unicorn'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

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

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Turbolinks also makes you mad when event binding doesn't work as expected
gem 'jquery-turbolinks', '2.0.2'

# Add devise for user authentication
gem 'devise', '3.2.2'

# Use paperclip for photo attachment
gem 'paperclip', '4.0.0'

# Use Amazon S3 for production file storage
gem 'aws-sdk', '1.33.0'

# Use acts-as-taggable-on for tagging
gem 'acts-as-taggable-on', '3.0.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

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
    gem 'meta_request', '0.2.8'

    gem 'sqlite3'
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
end


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
