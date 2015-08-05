class CreateJudicialDistricts < ActiveRecord::Migration
  def change
    create_table :judicial_districts do |t|
      t.string :short_name
      t.string :name
      t.integer :state_id

      t.timestamps null: false
    end
  end
end
