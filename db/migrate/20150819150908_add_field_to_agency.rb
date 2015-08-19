class AddFieldToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :street_number, :string
    add_column :agencies, :route, :string
    add_column :agencies, :city, :string
    add_column :agencies, :county, :string
    add_column :agencies, :state_code, :string
    add_column :agencies, :state_id, :integer
    add_column :agencies, :country, :string
    add_column :agencies, :zip_code, :string
    add_column :agencies, :latitude, :string
    add_column :agencies, :longitude, :string
  end
end
