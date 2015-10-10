class ProvidersController < ApplicationController
  layout "provider"

	def show
	  #id = params[:slug].split("-").last
	  @provider = BbbOverview.find_by(display_slug: params[:slug])

    @near_by_zip_code_providers = BbbOverview.search(id_not_eq: @provider.id, postal_code_cont: @provider.postal_code).result(distinct: true)
    @near_by_city_providers = BbbOverview.search(id_not_eq: @provider.id, locality_cont: @provider.locality).result(distinct: true)
    if @provider.nil?
      render file: "#{Rails.root}/public/404.html", status: 403, layout: false
    else
	  #@state = State.find_by(slug: params[:id])
    @additional_phones = BbbContact.where(bbb_overview_id: @provider.id, contact_type: "Phone").collect(&:contact_number)
    @additional_faxes = BbbContact.where(bbb_overview_id: @provider.id, contact_type: "Fax").collect(&:contact_number)
    set_default_values
    end
	end

  def set_default_values
    unless request.xhr?
      state_ids = Agency.select("distinct state_id")
      @states = State.where(id: state_ids).order(:name) 
    end
  end
end
