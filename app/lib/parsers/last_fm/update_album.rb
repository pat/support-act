# frozen_string_literal: true

module Parsers
  module LastFm
    class UpdateAlbum
      IMAGE_SIZE_RANKS = {
        "small"      => 1,
        "medium"     => 2,
        "large"      => 3,
        "extralarge" => 4
      }.freeze

      def self.call(hash, album = nil, ignore_artist: false)
        new.call(hash, album, :ignore_artist => ignore_artist)
      end

      # rubocop:disable Metrics/AbcSize
      def call(hash, album, ignore_artist: false)
        album ||= find_or_initialize_by_url_or_name(Album, hash)

        album.name          = hash["name"]
        album.last_fm_url ||= hash["url"]
        album.last_fm_raw   = hash
        album.mbid          = mbid(nil, hash["mbid"])
        album.image       ||= image(hash["image"])
        album.artist        = artist_for(hash["artist"]) unless ignore_artist
        album.save

        album
      end
      # rubocop:enable Metrics/AbcSize

      private

      def artist_for(hash)
        artist = find_or_initialize_by_url_or_name(Artist, hash)

        artist.name          = hash["name"]
        artist.last_fm_url ||= hash["url"]
        artist.last_fm_raw   = hash
        artist.mbid          = mbid(artist, hash["mbid"])
        artist.save

        artist
      end

      def find_or_initialize_by_url_or_name(model, hash)
        model.find_by(:last_fm_url => hash["url"]) ||
          model.find_by(:name => hash["name"]) ||
          model.new(:name => hash["name"], :last_fm_url => hash["url"])
      end

      def image(array)
        image = array.max_by { |hash| IMAGE_SIZE_RANKS.fetch(hash["size"], 0) }
        return nil unless image

        image["content"]
      end

      def images(array)
        array.each_with_object({}) do |hash, result|
          result[hash["size"]] = hash["content"]
        end
      end

      def mbid(object, value)
        value.presence || object&.mbid
      end
    end
  end
end
