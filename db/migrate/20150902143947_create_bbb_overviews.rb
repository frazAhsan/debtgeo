class CreateBbbOverviews < ActiveRecord::Migration
  def change
    create_table :bbb_overviews do |t|
      t.integer :agency_id
      t.string :accredited_since
      t.string :name
      t.string :phone
      t.string :fax
      t.string :business_link
      t.string :street_address
      t.string :locality
      t.string :region
      t.string :postal_code
      t.string :email
      t.string :rating
      t.string :additional_phone

      t.timestamps null: false
    end
  end
end
