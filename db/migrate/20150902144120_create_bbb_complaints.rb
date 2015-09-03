class CreateBbbComplaints < ActiveRecord::Migration
  def change
    create_table :bbb_complaints do |t|
      t.integer :bbb_overview_id
      t.string :complaint_type
      t.integer :total_closed_complaints

      t.timestamps null: false
    end
  end
end
