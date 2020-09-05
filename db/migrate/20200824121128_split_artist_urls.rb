# frozen_string_literal: true

class SplitArtistUrls < ActiveRecord::Migration[6.0]
  def up
    rename_column :artists, :url, :last_fm_url
    change_column_null :artists, :last_fm_url, true
    add_column :artists, :spotify_url, :string, :index => true

    execute <<~SQL.squish
      UPDATE artists
      SET spotify_url = last_fm_url
      WHERE last_fm_url LIKE 'spotify:%'
    SQL

    execute <<~SQL.squish
      UPDATE artists SET last_fm_url = NULL WHERE spotify_url IS NOT NULL
    SQL
  end

  def down
    execute <<~SQL.squish
      UPDATE artists
      SET last_fm_url = spotify_url
      WHERE spotify_url IS NOT NULL
    SQL

    remove_column :artists, :spotify_url
    change_column_null :artists, :last_fm_url, false
    rename_column :artists, :last_fm_url, :url
  end
end
