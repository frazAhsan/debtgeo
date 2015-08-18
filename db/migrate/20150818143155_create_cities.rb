class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :zip_code
      t.string :city
      t.integer :state_id
      t.string :state_code
      t.string :latitude
      t.string :longitude
      t.string :xaxis
      t.string :yaxis
      t.string :zaxis
      t.string :country
      t.string :location
      t.string :location_code

      t.timestamps null: false
    end
  end
end
