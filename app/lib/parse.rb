# frozen_string_literal: true

class Parse
  def self.call(fan)
    case fan.provider
    when "last_fm"
      Parsers::LastFm.call(fan)
    when "spotify"
      # Parsers::Spotify.call(fan)
    when NilClass
    else
      raise "Unknown provider"
    end
  end
end
