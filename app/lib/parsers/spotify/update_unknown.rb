# frozen_string_literal: true

module Parsers
  module Spotify
    class UpdateUnknown
      def self.call
        new.call
      end

      def call
        unknown_albums.find_each do |album|
          object = RSpotify::Album.search(
            %(album:"#{album.name}" artist:"#{album.artist.name}")
          ).first

          UpdateAlbum.call(object, album) unless object.nil?
        end
      end

      private

      def unknown_albums
        Album.where(:spotify_url => nil)
      end
    end
  end
end
