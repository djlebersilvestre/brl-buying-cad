ENV['RAILS_ENV'] ||= 'test'

require 'simplecov-rcov'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start do
  `git checkout origin/master coverage/.last_run.json`

  minimum_coverage(90)
  maximum_coverage_drop(2)

  add_filter 'spec/'
  add_filter 'config/'
  add_filter 'vendor/'
end

require File.expand_path('../../config/environment', __FILE__)
require 'vcr'
require 'webmock'
require 'rspec/rails'
require 'database_cleaner'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Print the 10 slowest examples and example groups
  # config.profile_examples = 10

  # Run specs in random order to surface order dependencies
  config.order = :random

  config.around(:each, :vcr) do |example|
    name = example.metadata[:cassette]
    options = example.metadata.slice(:record, :match_requests_on)
    options.except!(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock

  c.default_cassette_options = {
    record: :once,
    match_requests_on: %i(method uri body)
  }
end
