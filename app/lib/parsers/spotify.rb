# frozen_string_literal: true

module Parsers
  class Spotify
    def self.call(fan)
      new(fan).call
    end

    def initialize(fan)
      @fan = fan
    end

    def call
      fan.provider_cache_will_change!

      fan.provider_cache["latest_album_ids"] =
        top_albums.collect { |hash| album_for(hash).id }
      fan.save
    end

    private

    attr_reader :fan

    def album_for(hash)
      album = Album.find_by(:url => hash["url"])

      if album.nil?
        Album.create(
          :identifier => SecureRandom.uuid,
          :name       => hash["name"],
          :url        => hash["url"],
          :mbid       => mbid(nil, hash["mbid"]),
          :images     => images(hash["image"]),
          :artist     => artist_for(hash["artist"])
        )
      else
        album.update!(
          :name   => hash["name"],
          :mbid   => mbid(album, hash["mbid"]),
          :images => images(hash["image"]),
          :artist => artist_for(hash["artist"])
        )

        album
      end
    end

    def artist_for(hash)
      artist = Artist.find_by(:url => hash["url"])

      if artist.nil?
        Artist.create(
          :identifier => SecureRandom.uuid,
          :name       => hash["name"],
          :url        => hash["url"],
          :mbid       => mbid(nil, hash["mbid"])
        )
      else
        artist.update!(
          :name => hash["name"],
          :mbid => mbid(artist, hash["mbid"])
        )

        artist
      end
    end

    def images(array)
      array.each_with_object({}) do |hash, result|
        result[hash["size"]] = hash["content"]
      end
    end

    def spotify_user
      @spotify_user ||= RSpotify::User.new(fan.provider_cache["oauth"])
    end

    def top_songs
      spotify_user.top_tracks(:time_range => "short_term")
    end

    def top_albums
      #
    end
  end
end
