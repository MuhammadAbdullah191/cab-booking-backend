class CreateLocation < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.integer :status, null: false, default: 0
      t.float :latitude
      t.float :longitude
      t.references :locationable, polymorphic: true, null: false
    end
  end
end
