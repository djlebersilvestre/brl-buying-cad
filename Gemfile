source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '4.2.0'
gem 'unicorn'
gem 'pg'

# Sidekiq gems
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidekiq-scheduler'
gem 'sinatra', require: false

# Better abstract OO approach
gem 'abstract_method'

group :development, :test do
  gem 'seed_dump'
  gem 'rspec-sidekiq'
  gem 'web-console'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'vcr', require: false
  gem 'webmock', require: false
  gem 'rubycritic', require: false
  gem 'simplecov-rcov', require: false
  gem 'database_cleaner', require: false
end
