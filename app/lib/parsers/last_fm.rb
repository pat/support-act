# frozen_string_literal: true

module Parsers
  class LastFm
    IMAGE_SIZE_RANKS = {
      "small"      => 1,
      "medium"     => 2,
      "large"      => 3,
      "extralarge" => 4
    }.freeze

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
      album = find_or_initialize_by_url_or_name(Album, hash)

      album.name          = hash["name"]
      album.last_fm_url ||= hash["url"]
      album.last_fm_raw   = hash
      album.mbid          = mbid(nil, hash["mbid"])
      album.image       ||= image(hash["image"])
      album.artist        = artist_for(hash["artist"])
      album.save

      album
    end

    def artist_for(hash)
      artist = find_or_initialize_by_url_or_name(Artist, hash)

      artist.name          = hash["name"]
      artist.last_fm_url ||= hash["url"]
      artist.last_fm_raw   = hash
      artist.mbid          = mbid(artist, hash["mbid"])
      artist.save

      artist
    end

    def find_or_initialize_by_url_or_name(model, hash)
      model.find_by(:last_fm_url => hash["url"]) ||
        model.find_by(:name => hash["name"]) ||
        model.new(:name => hash["name"], :last_fm_url => hash["url"])
    end

    def image(array)
      image = array.
        sort_by { |hash| IMAGE_SIZE_RANKS.fetch(hash["size"], 0) }&.last
      return nil unless image

      image["content"]
    end

    def images(array)
      array.each_with_object({}) do |hash, result|
        result[hash["size"]] = hash["content"]
      end
    end

    def last_fm
      @last_fm ||= begin
        api = Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
        api.session = fan.provider_cache["token"]
        api
      end
    end

    def mbid(object, value)
      value.empty? ? object&.mbid : value
    end

    def top_albums
      @top_albums ||= last_fm.user.get_top_albums(
        :user   => fan.provider_identity,
        :period => "1month"
      )
    end
  end
end
