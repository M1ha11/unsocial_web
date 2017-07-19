# Shoryuken.configure_server do |config|
#   # Replace Rails logger so messages are logged wherever Shoryuken is logging
#   # Note: this entire block is only run by the processor, so we don't overwrite
#   #       the logger when the app is running as usual.

#   # Rails.logger = Shoryuken::Logging.logger
#   # Rails.logger.level = Rails.application.config.log_level

#   # config.server_middleware do |chain|
#   #  chain.add Shoryuken::MyMiddleware
#   # end

#   # For dynamically adding queues prefixed by Rails.env
#   # %w(queue1 queue2) do |name|
#   #   Shoryuken.add_queue("#{Rails.env}_#{name}, 1)
#   # end
# end

# Shoryuken.active_job_queue_name_prefixing = true
Shoryuken.options[:queues] = [
  ENV['queue_url']
]

# Shoryuken.configure_server do |config|
#   config.aws = {
#     sqs_endpoint: ENV["SQS_ENDPOINT"],
#     secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#     access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#     region: ENV["AWS_REGION"]
#   }
# end

# Shoryuken.configure_client do |config|
#   config.aws = {
#     sqs_endpoint: ENV["SQS_ENDPOINT"],
#     secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#     access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#     region: ENV["AWS_REGION"]
#   }
# end
