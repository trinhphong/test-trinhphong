# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string :uid
      t.string :provider
      t.string :avatar_url
      t.string :full_name

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
