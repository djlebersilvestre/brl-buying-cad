# host: ENV.fetch('BRLCAD_REDIS_HOST'),
# namespace: ENV.fetch('BRL_REDIS_NAMESPACE')
# TODO: improve this initializer - DOTENV
Rails.configuration.redis = {
  host: 'redis://127.0.0.1:6379',
  namespace: 'sidekiq:brl_buying_cad',
  password: 'testing'
}
