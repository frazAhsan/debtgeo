class AddBbbAccreditedToAgency < ActiveRecord::Migration
  def change
    add_column :agencies, :bbb_accredited, :boolean
  end
end
