# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.uuid :identifier, :null => false, :index => {:unique => true}
      t.string :name, :null => false
      t.string :url, :null => false, :index => true
      t.string :mbid
      t.jsonb :images, :null => false, :default => {}
      t.references :artist, :null => false, :foreign_key => true
      t.timestamps
    end
  end
end
