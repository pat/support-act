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
        top_albums.collect { |object| album_for(object).id }
      fan.save
    end

    private

    attr_reader :fan

    def album_for(object)
      album = find_or_initialize_by_url_or_name(Album, object)

      album.name          = object.name
      album.spotify_url ||= object.uri
      album.spotify_raw   = object.as_json
      album.image         = image(object.images)
      album.artist        = artist_for(object.artists.first)
      album.save

      album
    end

    def artist_for(object)
      artist = find_or_initialize_by_url_or_name(Artist, object)

      artist.name          = object.name
      artist.spotify_url ||= object.uri
      artist.spotify_raw   = object.as_json
      artist.save

      artist
    end

    def find_or_initialize_by_url_or_name(model, object)
      model.find_by(:spotify_url => object.uri) ||
        model.find_by(:name => object.name) ||
        model.new(:name => object.name, :spotify_url => object.uri)
    end

    def image(array)
      image = array.sort_by { |hash| hash["width"] }&.last
      return nil unless image

      image["url"]
    end

    def spotify_user
      @spotify_user ||= RSpotify::User.new(fan.provider_cache["oauth"])
    end

    def top_songs
      @top_songs ||= spotify_user.top_tracks(:limit => 50)
    end

    def top_albums
      @top_albums ||= top_songs.collect(&:album).uniq(&:uri)
    end
  end
end
