# frozen_string_literal: true

class AddUniquenessToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_index :purchases, %i[ fan_id album_id ], :unique => true
  end
end
