# frozen_string_literal: true

class Parse
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
