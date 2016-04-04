class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :job_type
      t.string :company_name
      t.string :title
      t.string :country
      t.string :city
      t.integer :start_month
      t.integer :start_year
      t.integer :end_month
      t.integer :end_year
      t.boolean :is_present
      t.string :industry
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
