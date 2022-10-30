# frozen_string_literal: true

class AddSubscribedToFans < ActiveRecord::Migration[7.0]
  def change
    add_column :fans, :subscribed, :boolean, :null => false, :default => true
    add_index :fans, :subscribed
  end
end
