class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country
      t.string :state
      t.string :city
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
