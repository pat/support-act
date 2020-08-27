# frozen_string_literal: true

module Parsers
  module MusicBrainz
    class Links
      def self.call(album)
        new(album).call
      end

      def initialize(album)
        @album = album
      end

      def call
        album.musicbrainz_checked_at = Time.current

        if urls.present?
          album.links_will_change!
          album.links["musicbrainz"] = Array(urls)
        end

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
        @urls ||= release.urls["purchase for download"]
      end
    end
  end
end
