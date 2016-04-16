source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1'
gem 'mongoid', '~> 4.0.0'
gem 'bson_ext'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'mongoid-paperclip', :require => "mongoid_paperclip"
gem 'aws-sdk'
gem 'devise'
gem 'roo'
gem 'dropbox-sdk', :require => "dropbox_sdk"
gem 'kaminari'
gem 'sidekiq'
gem 'sidekiq-status', github: 'utgarda/sidekiq-status'
gem 'owlcarousel-rails'
gem 'fastimage'
gem 'font-awesome-rails'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

group :production do
  gem 'unicorn-worker-killer'
end

group :development, :test do
  gem 'capistrano', '3.3.3'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'capybara'
  gem 'therubyracer'
end

# Use debugger
# gem 'debugger', group: [:development, :test]
