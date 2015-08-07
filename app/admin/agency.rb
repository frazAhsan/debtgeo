ActiveAdmin.register Agency do
  actions :all, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :organisation_id
    column :organisation_name
    column :address
    column :website
    actions
  end

  filter :organisation_name
  filter :website


end