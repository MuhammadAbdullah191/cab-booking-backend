class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :feedback, null: false, default: ''
      t.integer :rating, null: false
      t.references :booking, null: false, foreign_key: true
      t.timestamps
    end
  end
end
