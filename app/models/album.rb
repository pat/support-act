# frozen_string_literal: true

class Album < ApplicationRecord
  include Checkable

  belongs_to :artist

  before_validation :set_identifier, :on => :create

  scope :with_mbid, lambda { where.not(:mbid => nil) }
  scope :with_spotify_url, lambda { where.not(:spotify_url => nil) }

  def self.latest_for_fan(fan)
    ids = fan.provider_cache["latest_album_ids"][0..19]
    objects = yield(ids).includes(:artist).to_a

    ids.filter_map { |id| objects.detect { |object| object.id == id } }
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
