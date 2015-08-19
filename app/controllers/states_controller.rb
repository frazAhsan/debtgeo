class StatesController < ApplicationController

  def show
  	@state = State.friendly.find(params[:id])
  	unless request.xhr?
  		state_ids = Agency.select("distinct state_id")
  	@states = State.where(id: state_ids).order(:name) 
  end
	@agencies = Agency.where("state_id = ?", @state.id).page(params[:page]).per(10).order(:organisation_name)
  end
end
