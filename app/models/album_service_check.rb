# frozen_string_literal: true

class AlbumServiceCheck < ApplicationRecord
  belongs_to :album

  validates :service,         :presence => true
  validates :last_checked_at, :presence => true

  scope :missing_or_old, lambda { |service|
    where("service IS NULL OR service = ?", service).
      where("last_checked_at IS NULL or last_checked_at < ?", 3.months.ago)
  }

  def self.check(album, service)
    instance = find_or_initialize_by(
      :album   => album,
      :service => service
    )

    yield

    instance.last_checked_at = Time.current
    instance.save!
  end
end
