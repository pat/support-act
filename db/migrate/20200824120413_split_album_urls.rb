# frozen_string_literal: true

class SplitAlbumUrls < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/MethodLength
  def up
    rename_column :albums, :url, :last_fm_url
    change_column_null :albums, :last_fm_url, true
    add_column :albums, :spotify_url, :string

    execute <<~SQL.squish
      UPDATE albums
      SET spotify_url = last_fm_url
      WHERE last_fm_url LIKE 'spotify:%'
    SQL

    execute <<~SQL.squish
      UPDATE albums SET last_fm_url = NULL WHERE spotify_url IS NOT NULL
    SQL
  end
  # rubocop:enable Metrics/MethodLength

  def down
    execute <<~SQL.squish
      UPDATE albums
      SET last_fm_url = spotify_url
      WHERE spotify_url IS NOT NULL
    SQL

    remove_column :albums, :spotify_url
    change_column_null :albums, :last_fm_url, false
    rename_column :albums, :last_fm_url, :url
  end
end
