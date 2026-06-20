# frozen_string_literal: true

class AddActiveToFans < ActiveRecord::Migration[8.1]
  def change
    add_column :fans, :active, :boolean, :null => false, :default => true
    add_index :fans, :active
  end
end
