# frozen_string_literal: true

module Parsers
  module Bandcamp
    class Links
      def self.call
        Album.each_unchecked("bandcamp") do |album|
          new(album).call
        rescue StandardError => error
          Exceptions::LogForAlbum.call(error, album)
        ensure
          sleep 1 # Don't hit Bandcamp's servers too hard.
        end
      end

      def initialize(album)
        @album = album
      end

      def call
        return if search_result.nil?
        return if album_result.nil?

        album.links_will_change!
        album.links["bandcamp"] = ["#{artist_page}#{album_result["href"]}"]
        album.save!
      end

      private

      attr_reader :album

      def album_result
        @album_result ||= begin
          document = get("#{artist_page}/music")

          document.css("#music-grid li a").detect do |item|
            item.css("p.title").first.content.strip == album.name
          end
        end
      end

      def artist_page
        @artist_page ||= search_result["href"].sub(/\?.+$/, "")
      end

      def get(url, query: nil)
        response = Faraday.get(url) do |request|
          request.params["q"] = %("#{query}") if query
        end

        parse response, query, url
      end

      def parse(response, query, url)
        case response.status
        when 200..299
          Nokogiri::HTML(response.body)
        when 300..399
          get response.headers["Location"], :query => query
        else
          raise "Invalid response for #{url}: #{response.status} " \
                "(#{response.headers.inspect})"
        end
      end

      def search_result
        @search_result ||= begin
          document = get(
            "https://bandcamp.com/search", :query => album.artist.name
          )

          document.css(
            ".result-items .searchresult.band .heading a"
          ).detect do |link|
            link.content.strip == album.artist.name
          end
        end
      end
    end
  end
end
