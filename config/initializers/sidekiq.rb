require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = {
    url: Rails.configuration.redis[:host],
    namespace: Rails.configuration.redis[:namespace],
    password: Rails.configuration.redis[:password]
  }
  config.failures_default_mode = :all
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: Rails.configuration.redis[:host],
    namespace: Rails.configuration.redis[:namespace],
    password: Rails.configuration.redis[:password]
  }
end
