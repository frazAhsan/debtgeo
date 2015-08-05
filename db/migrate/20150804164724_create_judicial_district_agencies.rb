class CreateJudicialDistrictAgencies < ActiveRecord::Migration
  def change
    create_table :judicial_district_agencies do |t|
      t.integer :judicial_district_id
      t.integer :agency_id

      t.timestamps null: false
    end
  end
end
