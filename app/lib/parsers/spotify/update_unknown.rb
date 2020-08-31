# frozen_string_literal: true

module Parsers
  module Spotify
    class UpdateUnknown
      def self.call
        Album.where(:spotify_url => nil).each_unchecked("spotify") do |album|
          new(album).call
        end
      end

      def initialize(album)
        @album = album
      end

      def call
        object = RSpotify::Album.search(
          %(album:"#{album.name}" artist:"#{album.artist.name}")
        ).first

        UpdateAlbum.call(object, album) unless object.nil?
      end

      private

      attr_reader :album
    end
  end
end
