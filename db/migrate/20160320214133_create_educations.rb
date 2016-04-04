class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_type
      t.string :name
      t.string :major
      t.integer :end_year
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
