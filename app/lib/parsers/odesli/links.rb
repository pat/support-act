# frozen_string_literal: true

module Parsers
  module Odesli
    class Links
      ODESLI_ENDPOINT = "https://api.song.link/v1-alpha.1/links"

      def self.call
        Album.with_spotify_url.each_unchecked("odesli") do |album|
          new(album).call
          sleep 1 # to avoid Odesli rate-limits.
        rescue JSON::ParserError => error
          Exceptions::LogForAlbum.call(error, album)
        end
      end

      def initialize(album)
        @album = album
      end

      def call
        return if urls.blank?

        album.links_will_change!
        album.links["odesli"] = Array(urls)
        album.save!
      end

      private

      attr_reader :album

      def json
        @json ||= JSON.parse(response.body)
      end

      def response
        @response ||= Faraday.get(ODESLI_ENDPOINT) do |request|
          request.headers["Content-Type"] = "application/json"

          request.params["url"] = album.spotify_url
          request.params["userCountry"] = "AU"
          request.params["key"] = ENV.fetch("ODESLI_API_KEY")
        end
      end

      def urls
        return [] if json["linksByPlatform"].nil?

        json["linksByPlatform"].values.pluck("url")
      end
    end
  end
end
