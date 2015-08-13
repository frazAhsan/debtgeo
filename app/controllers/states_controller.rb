class StatesController < ApplicationController

  def show
  	@state = State.friendly.find(params[:id])
  	logger.info @state.id
  	@states = State.order(:name) unless request.xhr?
  	logger.info "AAAAAAAAAAAA"
	@agencies = Agency.joins(judicial_districts: [:state]).where("states.id = ?", @state.id).page(params[:page]).per(10).order(:organisation_name)
   logger.info "BBBBBBBBBBBBB"
  end
end
