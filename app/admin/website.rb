ActiveAdmin.register Website do
  permit_params :name, :domain, :city, :state_id, :language
    actions :all#, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :name
    column :domain
    column :city
    column :state
    column :language
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
      f.input :language, collection: [["English", "en"], ["French", "fr"]]
    end
    f.actions
  end

end