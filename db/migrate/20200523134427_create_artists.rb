# frozen_string_literal: true

class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.uuid :identifier, :null => false, :index => {:unique => true}
      t.string :name, :null => false
      t.string :url, :null => false, :index => true
      t.string :mbid
      t.timestamps
    end
  end
end
