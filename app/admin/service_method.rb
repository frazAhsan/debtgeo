ActiveAdmin.register ServiceMethod do
  actions :all, :except => [:new, :edit]

  index do
    selectable_column
    id_column
    column :agency
    column :service_method_name
    column :phone_number
    column :phone_extension
    column :web_site_url
    column :location_address_street_address1
    column :location_address_street_address2
    column :location_address_city
    column :location_address_state_code
    column :location_address_postal_code
    column :location_address_phone_number
    column :doing_business_as
    column :location_language_name
    column :translator_only_flag
    column :written_material_only_flag
    column :full_service_flag
    actions
  end

  filter :agency_organisation_name_eq, as: :select, collection: Agency.order(:organisation_name).collect { |cat| [cat.organisation_name, cat.id] }
  filter :service_method_name
end