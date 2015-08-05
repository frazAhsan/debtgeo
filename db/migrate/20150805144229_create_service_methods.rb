class CreateServiceMethods < ActiveRecord::Migration
  def change
    create_table :service_methods do |t|
      t.integer :agency_id
      t.string :service_method_name
      t.string :phone_number
      t.string :phone_extension
      t.string :web_site_url
      t.string :location_address_street_address1
      t.string :location_address_street_address2
      t.string :location_address_city
      t.string :location_address_state_code
      t.string :location_address_postal_code
      t.string :location_address_phone_number
      t.string :doing_business_as
      t.string :location_language_name
      t.string :translator_only_flag
      t.string :written_material_only_flag
      t.string :full_service_flag

      t.timestamps null: false
    end
  end
end
