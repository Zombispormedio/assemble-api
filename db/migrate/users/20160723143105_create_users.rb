class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid,                null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

    end
  end
end
