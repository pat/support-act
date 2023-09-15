# frozen_string_literal: true

class AddLinksToAlbums < ActiveRecord::Migration[6.0]
  def change
    change_table(:albums, :bulk => true) do |t|
      t.column :links_checked_at, :datetime
      t.column :links, :json, :default => {}, :null => false
    end
  end
end
