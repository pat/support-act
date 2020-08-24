# frozen_string_literal: true

class SplitAlbumRawData < ActiveRecord::Migration[6.0]
  def change
    rename_column :albums, :raw, :spotify_raw
    add_column :albums, :last_fm_raw, :jsonb, :default => {}, :null => false
  end
end
