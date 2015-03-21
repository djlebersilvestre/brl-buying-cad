source 'https://rubygems.org'
ruby '2.2.1'

# Rails and base gems
gem 'rails', '4.2.0'
gem 'unicorn'
gem 'pg'

# Sidekiq gems
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sidekiq-scheduler'
gem 'sinatra', require: false

# OO helpers
gem 'abstract_method'
gem 'descendants-loader'

# Dev and test
group :development, :test do
  gem 'seed_dump'
  gem 'web-console'
  gem 'byebug'
end

# Test only
group :test do
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'mutant-rspec'
  gem 'spring-commands-rspec'
  gem 'vcr', require: false
  gem 'webmock', require: false
  gem 'simplecov-rcov', require: false
  gem 'database_cleaner', require: false
end
