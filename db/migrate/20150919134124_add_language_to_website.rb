class AddLanguageToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :language, :string
  end
end
