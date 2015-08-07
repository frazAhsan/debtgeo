ActiveAdmin.register JudicialDistrict do
  actions :all, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :short_name
    column :name
    column :state
    actions
  end

  filter :short_name
  filter :name
  filter :state


end