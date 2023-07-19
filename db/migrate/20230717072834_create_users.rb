class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, default: '', limit: 25
      t.string :phone, null: false, limit: 13, default: ''
      t.string :type, default: '', null: false
      t.string :cnic
      t.string :license_number
      t.datetime :license_expiry

      t.timestamps
    end
  end
end
