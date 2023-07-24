class CreateOtps < ActiveRecord::Migration[6.0]
  def change
    create_table :otps do |t|
      t.string :code, null: false, default: ''
      t.datetime :expiration_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
