require 'qiniu'
Qiniu.establish_connection! access_key: Rails.application.secrets.qiniu_key,
                            secret_key: Rails.application.secrets.qiniu_secret
