# frozen_string_literal: true

class ChangeAlbumServiceChecksToServiceChecks < ActiveRecord::Migration[6.1]
  def change
    rename_table :album_service_checks, :service_checks
    remove_index :service_checks, [:album_id]
    rename_column :service_checks, :album_id, :checkable_id
    add_column :service_checks, :checkable_type, :string, :default => "Album"
    add_index :service_checks, %i[checkable_id checkable_type],
      :name => "index_service_checks_on_checkable"
  end
end
