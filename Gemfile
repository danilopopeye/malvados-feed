source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# mongoid files
gem 'mongoid'

# application
gem 'builder'
gem 'uglifier'
gem 'sass-rails'

# newrelic
gem 'newrelic_moped'
gem 'newrelic_rpm'

group :production do
  gem 'rails_12factor'
  gem 'memcachier'
  gem 'dalli'
end

group :test, :development do
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 2.14'
  gem 'factory_girl_rails'
  gem 'pry-remote'
  gem 'pry-plus'
  gem 'listen'
end

group :development do
  gem 'rails_best_practices', require: false
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'meta_request'
  gem 'guard-rails_best_practices'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-pow'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'be_valid_asset'
  gem 'mongoid-rspec'
  gem 'webmock'
end

group :other do
  gem 'codeclimate-test-reporter', require: false
  gem 'coveralls', require: false
  gem 'passenger', require: false
  gem 'nokogiri', require: false
end
