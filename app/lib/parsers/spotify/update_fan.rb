# frozen_string_literal: true

module Parsers
  module Spotify
    class UpdateFan
      def self.call(fan)
        new(fan).call
      end

      def initialize(fan)
        @fan = fan
      end

      def call
        fan.provider_cache_will_change!

        fan.provider_cache["latest_album_ids"] =
          top_albums.collect { |object| UpdateAlbum.call(object).id }
        fan.save
      end

      private

      attr_reader :fan

      def spotify_user
        @spotify_user ||= RSpotify::User.new(fan.provider_cache["oauth"])
      end

      def top_songs
        @top_songs ||= spotify_user.top_tracks(:limit => 50)
      end

      def top_albums
        @top_albums ||= top_songs.collect(&:album).uniq(&:uri)
      end
    end
  end
end
