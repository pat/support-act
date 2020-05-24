# frozen_string_literal: true

require "rspotify/oauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"],
    :scope => "user-top-read"
end

# Fix for: https://github.com/guilhermesad/rspotify/issues/189
# This can be removed if/when https://github.com/guilhermesad/rspotify/pull/196
# is merged in.
module OmniAuth
  module Strategies
    class Spotify < OmniAuth::Strategies::OAuth2
      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
