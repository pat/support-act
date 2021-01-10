# frozen_string_literal: true

class RemoveCheckableForeignKey < ActiveRecord::Migration[6.1]
  def up
    remove_foreign_key :service_checks, :column => :checkable_id
  end

  def down
    add_foreign_key :service_checks, :albums, :column => :checkable_id
  end
end
