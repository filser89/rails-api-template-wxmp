require 'qiniu'
Qiniu.establish_connection! access_key: Rails.application.credentials.qiniu_key,
  secret_key: Rails.application.credentials.qiniu_secret
