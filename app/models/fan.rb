# frozen_string_literal: true

class Fan < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :trackable,
    :recoverable, :rememberable, :validatable

  before_validation :set_identifier, :on => :create

  scope :confirmed, lambda { where("confirmed_at IS NOT NULL") }
  scope :with_provider, lambda { where("provider IS NOT NULL") }

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end
end
