# frozen_string_literal: true

module Parsers
  module MusicBrainz
    class Links
      def self.call
        Album.with_mbid.each_unchecked("musicbrainz") do |album|
          new(album).call
          sleep 1.1 # to avoid MusicBrainz rate-limits.
        end
      end

      def initialize(album)
        @album = album
      end

      def call
        return if urls.blank?

        album.links_will_change!
        album.links["musicbrainz"] = Array(urls)
        album.save!
      end

      private

      attr_reader :album

      def client
        @client ||= ::MusicBrainz::Client.new
      end

      def release
        @release ||= client.release album.mbid, :includes => "url-rels"
      end

      def urls
        return nil if release.nil?

        @urls ||= release.urls["purchase for download"]
      end
    end
  end
end
