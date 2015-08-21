class JudicialDistrictsController < ApplicationController

	def show
		id = params[:id].split("-").first
		@judicial_district = JudicialDistrict.find id
		@agencies = @judicial_district.agencies.page(params[:page]).per(10).order(:organisation_name)
		set_default_values
	end

  	def set_default_values
    	unless request.xhr?
    		@state = @judicial_district.state
      		state_ids = Agency.select("distinct state_id")
      		@states = State.where(id: state_ids).order(:name) 
      		filtered_infos = Agency.select("zip_code, city, county").where("state_id = ?", @state.id)
      		@zip_codes = filtered_infos.collect(&:zip_code)
      		@cities = filtered_infos.collect(&:city)
          @counties = filtered_infos.collect(&:county)
      		@judicial_districts = JudicialDistrict.where(state_id: @judicial_district.state_id)
    	end
  	end
end
