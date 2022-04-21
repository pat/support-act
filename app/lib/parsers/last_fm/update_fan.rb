# frozen_string_literal: true

module Parsers
  module LastFm
    class UpdateFan
      def self.call(fan)
        new(fan).call
      end

      def initialize(fan)
        @fan = fan
      end

      def call
        fan.provider_cache_will_change!

        fan.provider_cache["latest_album_ids"] =
          top_albums.collect { |hash| UpdateAlbum.call(hash).id }
        fan.save
      end

      private

      attr_reader :fan

      def last_fm
        @last_fm ||= begin
          api = Lastfm.new(
            ENV.fetch("LAST_FM_API_KEY"), ENV.fetch("LAST_FM_API_SECRET")
          )
          api.session = fan.provider_cache["token"]
          api
        end
      end

      def top_albums
        @top_albums ||= begin
          results = last_fm.user.get_top_albums(
            :user   => fan.provider_identity,
            :period => "1month"
          ) || []

          results.is_a?(Hash) ? [results] : results
        end
      end
    end
  end
end
