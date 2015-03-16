require 'sidekiq/web'

# TODO: improve this initializer - use config files
redis_host = 'redis://172.17.0.3:6379'
redis_namespace = 'sidekiq:brl_buying_cad'

Sidekiq.configure_server do |config|
  config.redis = {
    url: redis_host,
    namespace: redis_namespace,
  }
  config.failures_default_mode = :all
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_host,
    namespace: redis_namespace,
  }
end
