class ProvidersController < ApplicationController
  layout "provider"

	def show
	  #id = params[:slug].split("-").last
	  @provider = BbbOverview.find_by(display_slug: params[:slug])
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
      
      #@zip_codes = Agency.select("distinct(zip_code)").where("state_id = ? and zip_code is not null", @state.id).collect(&:zip_code).sort
      #@cities = Agency.select("distinct(city)").where("state_id = ? and city is not null", @state.id).collect(&:city).sort
      #@counties = Agency.select("distinct(county)").where("state_id = ? and county is not null", @state.id).collect(&:county).sort
      #@judicial_districts = JudicialDistrict.where(state_id: @state.id).order(:name)
    end
  end
end
