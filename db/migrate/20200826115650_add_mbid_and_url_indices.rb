# frozen_string_literal: true

class AddMbidAndUrlIndices < ActiveRecord::Migration[6.0]
  def change
    add_index :albums, :mbid
    add_index :artists, :mbid
    add_index :albums, :spotify_url
    add_index :artists, :spotify_url
  end
end
