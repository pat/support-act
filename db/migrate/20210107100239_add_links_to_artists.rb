class AddLinksToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :links, :json, :default => {}, :null => false
  end
end
