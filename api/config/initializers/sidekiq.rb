Sidekiq.configure_server do |config|
  Rails.logger.level = Logger::INFO # don't want sidekiq to log SQL to the rails logfile
  config.redis = { url: "redis://127.0.0.1:6379/10" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://127.0.0.1:6379/10" }
end
