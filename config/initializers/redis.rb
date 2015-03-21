Rails.configuration.redis = {
  host: ENV.fetch('BRLCAD_REDIS_HOST'),
  namespace: ENV.fetch('BRLCAD_REDIS_NAMESPACE'),
  password: ENV.fetch('BRLCAD_REDIS_PASSWORD'),
}
