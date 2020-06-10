# frozen_string_literal: true

class AddDeviseToFans < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.up
    change_table :fans, :bulk => true do |t|
      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # Only if lock strategy is :failed_attempts
      # t.integer  :failed_attempts, default: 0, null: false
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
    end

    add_index :fans, :email,                :unique => true
    add_index :fans, :reset_password_token, :unique => true
    add_index :fans, :confirmation_token,   :unique => true
    # add_index :fans, :unlock_token,         unique: true
  end

  def self.down
    change_table :fans, :bulk => true do |t|
      t.remove_index :email
      t.remove_index :reset_password_token
      t.remove_index :confirmation_token

      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip
      t.remove :confirmation_token
      t.remove :confirmation_at
      t.remove :confirmation_sent_at
      t.remove :unconfirmed_email
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
