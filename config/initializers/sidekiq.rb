Sidekiq.configure_server do |config|
  # redisサーバの場所を指定（'herokuで使う場合', 'ローカルPC上で使う場合'）
  # ENVに「REDIS_URL」があればそちらを使い、なければ「redis://localhost:6379」を使う
  # herokuではlocalhostは使えないので、環境変数で設定できるようにしている
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379')}
end
