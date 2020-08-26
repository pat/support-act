# frozen_string_literal: true

class AddLinksToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :links_checked_at, :datetime, :index => true
    add_column :albums, :links, :json, :default => {}, :null => false
  end
end
