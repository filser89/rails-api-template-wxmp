class ImageUploadWorker
  include Sidekiq::Worker
  sidekiq_options failures: true, retry: 3, backtrace: 20, queue: :default

  def perform(options={})
    p "options #{options}"
  end
end
