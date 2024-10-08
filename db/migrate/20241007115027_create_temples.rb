class CreateTemples < ActiveRecord::Migration[7.0]
  def change
    create_table :temples do |t|
      t.string :name
      t.string :location
      t.text :description
      t.decimal :latitude
      t.decimal :longitude
      t.date :founding_date
      t.string :deity

      t.timestamps
    end
  end
end
