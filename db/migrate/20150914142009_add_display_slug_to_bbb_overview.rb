class AddDisplaySlugToBbbOverview < ActiveRecord::Migration
  def change
    add_column :bbb_overviews, :display_slug, :string
    add_column :agencies, :display_slug, :string
  end
end
