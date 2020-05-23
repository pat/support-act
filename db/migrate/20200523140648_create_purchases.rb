# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :album, :null => false, :foreign_key => true
      t.references :fan, :null => false, :foreign_key => true
      t.timestamps
    end
  end
end
