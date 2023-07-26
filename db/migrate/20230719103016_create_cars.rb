class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :reg_number, null: false, default: ''
      t.string :make, null: false, default: ''
      t.string :model, null: false, default: ''
      t.integer :seats, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
