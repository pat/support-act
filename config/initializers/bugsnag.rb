# frozen_string_literal: true

return unless defined?(Bugsnag)

Bugsnag.configure do |config|
  config.api_key               = ENV.fetch("BUGSNAG_API_KEY")
  config.notify_release_stages = %w[ production staging ]
  config.release_stage         = ENV.fetch("BUGSNAG_RELEASE_STAGE")
end
