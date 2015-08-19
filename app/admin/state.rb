ActiveAdmin.register State do
  permit_params :name, :state_code

  actions :all#, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :state_code
    column :name
    actions
  end

  filter :state_code
  filter :name


end