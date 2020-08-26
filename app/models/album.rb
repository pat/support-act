# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :artist

  before_validation :set_identifier, :on => :create

  scope :unlinked, lambda { where("links_checked_at IS NULL") }
  scope :with_mbid, lambda { where("mbid IS NOT NULL") }

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
