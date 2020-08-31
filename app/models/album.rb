# frozen_string_literal: true

class Album < ApplicationRecord
  JOIN_CLAUSE = "LEFT OUTER JOIN album_service_checks ON " \
    "album_id = albums.id AND service = ?"

  belongs_to :artist
  has_many :album_service_checks, :dependent => :delete_all

  before_validation :set_identifier, :on => :create

  scope :with_mbid, lambda { where("mbid IS NOT NULL") }
  scope :with_spotify_url, lambda { where("spotify_url IS NOT NULL") }
  scope :without_recent_check, lambda { |service|
    join = sanitize_sql([JOIN_CLAUSE, service])
    joins(join).merge(AlbumServiceCheck.missing_or_old)
  }

  def self.each_unchecked(service)
    without_recent_check(service).find_each do |album|
      AlbumServiceCheck.check(album, "musicbrainz") do
        yield album
      end
    end
  end

  def self.latest_for_fan(fan)
    ids = fan.provider_cache["latest_album_ids"][0..19]
    objects = yield(ids).includes(:artist).to_a

    ids.collect { |id| objects.detect { |object| object.id == id } }.compact
  end

  def self.not_purchased_by(fan)
    latest_for_fan(fan) do |ids|
      where(
        "id IN (?) AND id NOT IN (?)",
        ids,
        Purchase.where(:fan => fan).select(:album_id)
      )
    end
  end

  def self.purchased_by(fan)
    latest_for_fan(fan) do |ids|
      where(
        "id IN (?) AND id IN (?)",
        ids,
        Purchase.where(:fan => fan).select(:album_id)
      )
    end
  end

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
