# frozen_string_literal: true

class Parse
  def self.call(fan)
    case fan.provider
    when "last.fm"
      Parsers::LastFm::UpdateFan.call(fan)
    when "spotify"
      Parsers::Spotify.call(fan)
    when NilClass
      # Do nothing
    else
      raise "Unknown provider"
    end
  end
end
