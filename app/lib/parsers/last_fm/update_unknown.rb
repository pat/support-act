# frozen_string_literal: true

module Parsers
  module LastFm
    class UpdateUnknown
      def self.call
        new.call
      end

      def call
        unknown_albums.find_each do |album|
          hash = last_fm.album.get_info(
            :album       => album.name,
            :artist      => album.artist.name,
            :autocorrect => 1
          )

          UpdateAlbum.call(hash, album, :ignore_artist => true)
        end
      end

      private

      def last_fm
        @last_fm ||= Lastfm.new(
          ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"]
        )
      end

      def unknown_albums
        Album.where(:last_fm_url => nil)
      end
    end
  end
end
