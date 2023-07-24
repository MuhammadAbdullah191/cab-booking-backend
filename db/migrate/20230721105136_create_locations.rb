class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.decimal :latitude, null: false, default: ''
      t.decimal :longitude, null: false, default: ''
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
