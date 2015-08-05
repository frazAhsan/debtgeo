class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.integer :organisation_id
      t.string :organisation_name
      t.string :address
      t.string :website

      t.timestamps null: false
    end
  end
end
