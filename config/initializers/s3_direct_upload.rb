S3DirectUpload.config do |c|
  c.access_key_id     = AWS.config.access_key_id 
  c.secret_access_key = AWS.config.secret_access_key 
  c.bucket            = Rails.env.production? ? "nutshell-360" : "nutshell-360-dev"
  c.region            = nil
  c.url               = nil
end