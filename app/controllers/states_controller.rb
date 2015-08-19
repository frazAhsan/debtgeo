class StatesController < ApplicationController

  def show
  	@state = State.friendly.find(params[:id])
  	unless request.xhr?
  		state_ids = Agency.select("distinct state_id")
  		@states = State.where(id: state_ids).order(:name) 
  		filtered_infos = Agency.select("zip_code, city").where("state_id = ?", @state.id)
  		@zip_codes = filtered_infos.collect(&:zip_code)
  		@cities = filtered_infos.collect(&:city)
  	end
	@agencies = Agency.where("state_id = ?", @state.id).page(params[:page]).per(10).order(:organisation_name)
  end
end
