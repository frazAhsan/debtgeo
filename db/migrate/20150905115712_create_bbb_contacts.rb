class CreateBbbContacts < ActiveRecord::Migration
  def change
    create_table :bbb_contacts do |t|
      t.string :contact_type
      t.string :contact_number
      t.integer :bbb_overview_id

      t.timestamps null: false
    end
    remove_column :bbb_overviews, :additional_phone
  end
end
