# frozen_string_literal: true

spotify_client_id = ENV.fetch("SPOTIFY_CLIENT_ID", nil)
spotify_client_secret = ENV.fetch("SPOTIFY_CLIENT_SECRET", nil)

if spotify_client_id && spotify_client_secret
  RSpotify.authenticate(spotify_client_id, spotify_client_secret)
elsif Rails.env.production?
  raise "No spotify creds provided"
end
