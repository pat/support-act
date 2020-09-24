# frozen_string_literal: true

module Parsers
  module Spotify
    class UpdateAlbum
      def self.call(object, album = nil)
        new.call(object, album)
      end

      # rubocop:disable Metrics/AbcSize
      def call(object, album = nil)
        album ||= find_or_initialize_by_url_or_name(Album, object)

        album.name          = object.name
        album.spotify_url ||= object.uri
        album.spotify_raw   = object.as_json
        album.image         = image(object.images)
        album.artist        = artist_for(object.artists.first, album.artist)
        album.save

        album
      end
      # rubocop:enable Metrics/AbcSize

      private

      def artist_for(object, artist = nil)
        artist ||= find_or_initialize_by_url_or_name(Artist, object)

        artist.name          = object.name
        artist.spotify_url ||= object.uri
        artist.spotify_raw   = object.as_json
        artist.save

        artist
      end

      def find_or_initialize_by_url_or_name(model, object)
        model.find_by(:spotify_url => object.uri) ||
          model.find_by(:name => object.name) ||
          model.new(:name => object.name, :spotify_url => object.uri)
      end

      def image(array)
        image = array.sort_by { |hash| hash["width"] }&.last
        return nil unless image

        image["url"]
      end
    end
  end
end
