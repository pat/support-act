# frozen_string_literal: true

class Album < ApplicationRecord
  belongs_to :artist

  before_validation :set_identifier, :on => :create

  def self.latest_for_fan(fan)
    ids = fan.provider_cache["latest_album_ids"][0..19]
    objects = where(:id => ids).includes(:artist).to_a

    ids.collect do |id|
      objects.detect { |object| object.id == id }
    end
  end

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
