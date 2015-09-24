class AddSeoTemplateToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :seo_template, :string
  end
end
