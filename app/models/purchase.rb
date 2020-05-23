# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :album
  belongs_to :fan
end
