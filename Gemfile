source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# mongoid files
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext'

# application
gem 'nokogiri', require: false
gem 'builder'

group :test, :development do
  gem 'pry'
  gem 'debugger'
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
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'be_valid_asset'
  gem 'mongoid-rspec'
  gem 'webmock'
end
