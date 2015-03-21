require 'sidekiq/web'

# TODO: improve this initializer - use config files
redis_host = 'redis://127.0.0.1:6379'
redis_namespace = 'sidekiq:brl_buying_cad'
redis_password = 'testing'

Sidekiq.configure_server do |config|
  config.redis = {
    url: redis_host,
    namespace: redis_namespace,
    password: redis_password
  }
  config.failures_default_mode = :all
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_host,
    namespace: redis_namespace,
    password: redis_password
  }
end
