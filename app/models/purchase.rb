# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :album
  belongs_to :fan

  validates :album_id, :uniqueness => {:scope => :fan_id}

  scope :for_fan_and_albums, lambda { |fan, albums|
    where(:fan => fan, :album => albums)
  }
end
