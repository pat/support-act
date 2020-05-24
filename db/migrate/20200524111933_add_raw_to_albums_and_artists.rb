# frozen_string_literal: true

class AddRawToAlbumsAndArtists < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :raw, :jsonb, :null => false, :default => {}
    add_column :artists, :raw, :jsonb, :null => false, :default => {}
  end
end
