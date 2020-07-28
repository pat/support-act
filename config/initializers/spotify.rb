# frozen_string_literal: true

spotify_client_id = ENV["SPOTIFY_CLIENT_ID"]
spotify_client_secret = ENV["SPOTIFY_CLIENT_SECRET"]

if spotify_client_id && spotify_client_secret
  RSpotify.authenticate(spotify_client_id, spotify_client_secret)
elsif Rails.env.production?
  raise "No spotify creds provided"
end
