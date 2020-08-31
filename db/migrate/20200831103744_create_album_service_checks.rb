# frozen_string_literal: true

class CreateAlbumServiceChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :album_service_checks do |t|
      t.references :album, :null => false, :foreign_key => true
      t.string :service, :null => false
      t.datetime :last_checked_at, :null => false
      t.timestamps
    end
  end
end
