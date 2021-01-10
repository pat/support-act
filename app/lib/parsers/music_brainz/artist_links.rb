# frozen_string_literal: true

module Parsers
  module MusicBrainz
    class ArtistLinks
      def self.call
        Artist.with_mbid.each_unchecked("musicbrainz") do |artist|
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

      def mb_artist
        @mb_artist ||= client.artist artist.mbid, :includes => "url-rels"
      end

      def urls
        return nil if mb_artist.nil?

        @urls ||= mb_artist.urls
      end
    end
  end
end
