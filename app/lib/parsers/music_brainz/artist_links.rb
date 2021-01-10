# frozen_string_literal: true

module Parsers
  module MusicBrainz
    class ArtistLinks
      def self.call
        Artist.with_mbid.each do |artist|
          new(artist).call
          sleep 1.1 # to avoid MusicBrainz rate-limits.
        end
      end

      def initialize(artist)
        @artist = artist
      end

      def call
        return if urls.blank?

        artist.links_will_change!
        artist.links["musicbrainz"] = urls
        artist.save!
      end

      private

      attr_reader :artist

      def client
        @client ||= ::MusicBrainz::Client.new
      end

      def release
        @release ||= client.artist artist.mbid, :includes => "url-rels"
      end

      def urls
        return nil if release.nil?

        @urls ||= release.urls
      end
    end
  end
end
