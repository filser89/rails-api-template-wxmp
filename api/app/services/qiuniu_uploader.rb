# documentation: https://developer.qiniu.com/kodo/sdk/1304/ruby
class QiniuUploader
  IMAGES_BUCKET = 'AmigoImages'.freeze
  VIDEOS_BUCKET = 'AmigoVideos'.freeze

  def self.upload(file_name, file_buf, bucket = nil)
    uptoken = fetch_uptoken(file_name, bucket)

    if bucket.nil?
      # default to Image Bucket
      code, result, response_headers = Qiniu::Storage.upload_buffer_with_token(uptoken, file_buf, file_name, nil, bucket: IMAGES_BUCKET)
    else
      code, result, response_headers = Qiniu::Storage.upload_buffer_with_token(uptoken, file_buf, file_name, nil, bucket: bucket)
    end

    if code == 200
      return result['key']
    else
      Rails.logger.info("qiniu upload failed, code #{code}")
      raise 'Could not upload to Qiniu'.freeze
    end
  end

  private

  def self.fetch_uptoken(file_name, bucket)
    if bucket.nil?
      put_policy = Qiniu::Auth::PutPolicy.new(IMAGES_BUCKET, file_name, 3600)
    else
      put_policy = Qiniu::Auth::PutPolicy.new(bucket, file_name, 3600)
    end
    return Qiniu::Auth.generate_uptoken(put_policy)
  end
end
