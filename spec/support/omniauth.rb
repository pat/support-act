# frozen_string_literal: true

OmniAuth.config.test_mode = true

OmniAuth.config.add_mock :spotify,
  :id           => "supportactfan",
  :uri          => "spotify:user:supportactfan",
  :href         => "https://api.spotify.com/v1/users/supportactfan",
  :type         => "user",
  :display_name => "supportactfan",
  :credentials  => {
    :token         => SecureRandom.uuid,
    :refresh_token => SecureRandom.uuid
  }
