class AddAdditionInfoToBbbOverview < ActiveRecord::Migration
  def change
    add_column :bbb_overviews, :complaint_summary, :string
    add_column :bbb_overviews, :complaint_additional_info, :text
  end
end
