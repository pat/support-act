# frozen_string_literal: true

class Fan < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :trackable,
    :recoverable, :rememberable, :validatable

  before_validation :set_identifier, :on => :create

  scope :confirmed, lambda { where.not(:confirmed_at => nil) }
  scope :subscribed, lambda { where(:subscribed => true) }
  scope :with_provider, lambda { where.not(:provider => nil) }
  scope :with_provider, lambda { where(:active => true) }

  def self.subscribed_with_provider
    confirmed.with_provider.subscribed.active
  end

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
