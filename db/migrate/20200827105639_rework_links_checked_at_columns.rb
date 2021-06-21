# frozen_string_literal: true

class ReworkLinksCheckedAtColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :albums, :links_checked_at, :musicbrainz_checked_at
    add_column :albums, :odesli_checked_at, :datetime
  end
end
