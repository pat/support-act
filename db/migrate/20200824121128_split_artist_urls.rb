# frozen_string_literal: true

class SplitArtistUrls < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/MethodLength
  def up
    change_table :artists, :bulk => true do |t|
      t.rename :url, :last_fm_url
      t.change_null :last_fm_url, true
      t.column :spotify_url, :string
    end

    execute <<~SQL.squish
      UPDATE artists
      SET spotify_url = last_fm_url
      WHERE last_fm_url LIKE 'spotify:%'
    SQL

    execute <<~SQL.squish
      UPDATE artists SET last_fm_url = NULL WHERE spotify_url IS NOT NULL
    SQL
  end
  # rubocop:enable Metrics/MethodLength

  def down
    execute <<~SQL.squish
      UPDATE artists
      SET last_fm_url = spotify_url
      WHERE spotify_url IS NOT NULL
    SQL

    change_table :artists, :bulk => true do |t|
      t.remove :spotify_url
      t.change_null :last_fm_url, false
      t.rename :last_fm_url, :url
    end
  end
end
