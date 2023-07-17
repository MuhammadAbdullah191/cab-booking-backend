class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, default: '', limit: 25
      t.string :phone, null: false, limit: 13, default: ''
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
