ActiveAdmin.register Website do
  permit_params :name, :domain, :city, :state_id, :seo_template
    actions :all#, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :name
    column :domain
    column :city
    column :state
    column :seo_template
    actions
  end

  filter :name
  filter :domain
  filter :state
  
  form do |f|
    f.inputs "Website Details" do
      f.input :name
      f.input :domain
      f.input :city
      f.input :state
      f.input :seo_template, collection: [["Format 1", "1"], ["Format 2", "2"], ["Format 3", "3"], ["Format 4", "4"], ["Format 5", "5"]]
    end
    f.actions
  end

end