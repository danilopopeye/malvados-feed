source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# mongoid files
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext'

# application
gem 'nokogiri', require: false
gem 'builder'
gem 'uglifier'
gem 'sass-rails'
gem 'passenger', require: false

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'memcachier'
  gem 'dalli'
end

group :test, :development do
  gem 'pry'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :development do
  gem 'rails_best_practices', :require => false
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'meta_request'
  gem 'guard-rails_best_practices'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-zeus'
  gem 'guard-pow'
  gem 'debugger'
end

group :test do
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'be_valid_asset'
  gem 'mongoid-rspec'
  gem 'webmock'
end
