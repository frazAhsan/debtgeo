ActiveAdmin.register JudicialDistrictAgency do
  actions :all, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :judicial_district
    column :agency
    actions
  end

  filter :judicial_district
  filter :agency_organisation_name_eq, as: :select, collection: Agency.order(:organisation_name).collect { |cat| [cat.organisation_name, cat.id] }
end