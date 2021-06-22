# frozen_string_literal: true

class RemoveOdesliMusicbrainzTimestamps < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/MethodLength
  def up
    execute <<~SQL.squish
      INSERT INTO album_service_checks (
        album_id, service, last_checked_at, created_at, updated_at
      )
      SELECT id, 'musicbrainz', musicbrainz_checked_at, musicbrainz_checked_at,
        musicbrainz_checked_at
      FROM albums
      WHERE musicbrainz_checked_at IS NOT NULL
    SQL

    execute <<~SQL.squish
      INSERT INTO album_service_checks (
        album_id, service, last_checked_at, created_at, updated_at
      )
      SELECT id, 'odesli', odesli_checked_at, odesli_checked_at,
        odesli_checked_at
      FROM albums
      WHERE odesli_checked_at IS NOT NULL
    SQL

    remove_column :albums, :musicbrainz_checked_at
    remove_column :albums, :odesli_checked_at
  end

  def down
    add_column :albums, :musicbrainz_checked_at, :datetime
    add_index :albums, :musicbrainz_checked_at
    add_column :albums, :odesli_checked_at, :datetime
    add_index :albums, :odesli_checked_at

    execute <<~SQL.squish
      UPDATE albums
      SET musicbrainz_checked_at = album_service_checks.last_checked_at
      FROM album_service_checks
      WHERE album_service_checks.album_id = albums.id
    SQL

    execute <<~SQL.squish
      UPDATE albums
      SET odesli_checked_at = album_service_checks.last_checked_at
      FROM album_service_checks
      WHERE album_service_checks.album_id = albums.id
    SQL
  end
  # rubocop:enable Metrics/MethodLength
end
