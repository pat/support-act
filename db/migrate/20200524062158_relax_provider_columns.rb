# frozen_string_literal: true

class RelaxProviderColumns < ActiveRecord::Migration[6.0]
  def up
    change_table :fans, :bulk => true do |t|
      t.change_null :provider, true
      t.change_null :provider_identity, true

      t.change_null :email, false
    end
  end

  def down
    change_table :fans, :bulk => true do |t|
      t.change_null :provider, false
      t.change_null :provider_identity, false

      t.change_null :email, true
    end
  end
end
