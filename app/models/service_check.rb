# frozen_string_literal: true

class ServiceCheck < ApplicationRecord
  belongs_to :checkable, :polymorphic => true

  validates :service,         :presence => true
  validates :last_checked_at, :presence => true

  scope :missing_or_old, lambda {
    where("last_checked_at IS NULL or last_checked_at < ?", 3.months.ago)
  }

  def self.check(checkable, service)
    instance = find_or_initialize_by(
      :checkable => checkable,
      :service   => service
    )

    yield

    instance.last_checked_at = Time.current
    instance.save!
  end
end
