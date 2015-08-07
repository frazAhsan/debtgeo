ActiveAdmin.register Website do
  permit_params :name, :domain, :city, :state_id

  index do
    selectable_column
    id_column
    column :name
    column :domain
    column :city
    column :state
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
    end
    f.actions
  end

end