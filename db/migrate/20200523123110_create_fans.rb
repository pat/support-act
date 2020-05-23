# frozen_string_literal: true

class CreateFans < ActiveRecord::Migration[6.0]
  def change
    create_table :fans do |t|
      t.uuid :identifier, :null => false, :index => {:unique => true}
      t.string :provider, :null => false
      t.string :provider_identity, :null => false
      t.jsonb :provider_cache, :null => false, :default => {}
      t.string :email
      t.timestamps
    end
  end
end
