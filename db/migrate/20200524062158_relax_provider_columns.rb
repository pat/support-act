# frozen_string_literal: true

class RelaxProviderColumns < ActiveRecord::Migration[6.0]
  def up
    change_column_null :fans, :provider, true
    change_column_null :fans, :provider_identity, true

    change_column_null :fans, :email, false
  end

  def down
    change_column_null :fans, :provider, false
    change_column_null :fans, :provider_identity, false

    change_column_null :fans, :email, true
  end
end
