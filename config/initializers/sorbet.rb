T::Configuration.inline_type_error_handler = lambda do |error|
  Rails.logger.error error.message
end

T::Configuration.call_validation_error_handler = lambda do |_signature, opts|
  Rails.logger.error opts[:message]
end

T::Configuration.sig_builder_error_handler = lambda do |error, _location|
  Rails.logger.error error.message
end

T::Configuration.sig_validation_error_handler = lambda do |error, _opts|
  Rails.logger.error error.message
end
