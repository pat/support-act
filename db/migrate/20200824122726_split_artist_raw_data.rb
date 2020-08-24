# frozen_string_literal: true

class SplitArtistRawData < ActiveRecord::Migration[6.0]
  def change
    rename_column :artists, :raw, :spotify_raw
    add_column :artists, :last_fm_raw, :jsonb, :default => {}, :null => false
  end
end
