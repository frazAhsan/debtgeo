class JudicialDistrictsController < ApplicationController

	def show
		name = params[:id].gsub("-", " ")
		@judicial_district = JudicialDistrict.where("lower(name) = ?", name).first
		@agencies = @judicial_district.agencies.includes(:service_methods).page(params[:page]).per(10).order(:organisation_name).distinct
		set_default_values
	end

  	def set_default_values
    	unless request.xhr?
    		@state = @judicial_district.state
      	state_ids = Agency.select("distinct state_id")
      	@states = State.where(id: state_ids).order(:name) 
        #filtered_infos = Agency.select("distinct(zip_code), distinct(city), distinct(county)").where("state_id = ?", @state.id)
        @zip_codes = Agency.select("distinct(zip_code)").where("state_id = ?", @state.id).collect(&:zip_code).sort
        @cities = Agency.select("distinct(city)").where("state_id = ?", @state.id).collect(&:city).sort
        @counties = Agency.select("distinct(county)").where("state_id = ?", @state.id).collect(&:county).sort
        @judicial_districts = JudicialDistrict.where(state_id: @state.id).order(:name)
    	end
  	end
end
