# frozen_string_literal: true

class Artist < ApplicationRecord
  before_validation :set_identifier, :on => :create

  scope :with_mbid, lambda { where.not(:mbid => nil) }

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
