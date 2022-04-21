# frozen_string_literal: true

require "rspotify/oauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,
    ENV.fetch("SPOTIFY_CLIENT_ID", nil),
    ENV.fetch("SPOTIFY_CLIENT_SECRET", nil),
    :scope => "user-top-read"
end
