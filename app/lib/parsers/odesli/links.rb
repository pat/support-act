# frozen_string_literal: true

module Parsers
  module Odesli
    class Links
      ODESLI_ENDPOINT = "https://api.song.link/v1-alpha.1/links"

      def self.call(album)
        new(album).call
      end

      def initialize(album)
        @album = album
      end

      def call
        album.odesli_checked_at = Time.current

        if urls.present?
          album.links_will_change!
          album.links["odesli"] = Array(urls)
        end

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
          request.params["key"] = ENV["ODESLI_API_KEY"]
        end
      end

      def urls
        return [] if json["linksByPlatform"].nil?

        json["linksByPlatform"].values.collect { |hash| hash["url"] }
      end
    end
  end
end
