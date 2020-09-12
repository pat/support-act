# frozen_string_literal: true

module Parsers
  module LastFm
    class UpdateUnknown
      def self.call
        Album.where(:last_fm_url => nil).each_unchecked("last.fm") do |album|
          new(album).call
        end
      end

      def initialize(album)
        @album = album
      end

      def call
        hash = last_fm.album.get_info(
          :album       => album.name,
          :artist      => album.artist.name,
          :autocorrect => 1
        )

        UpdateAlbum.call(hash, album, :ignore_artist => true)
      rescue Lastfm::ApiError => error
        raise error unless error.message == "Album not found"
      end

      private

      attr_reader :album

      def last_fm
        @last_fm ||= Lastfm.new(
          ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"]
        )
      end
    end
  end
end
