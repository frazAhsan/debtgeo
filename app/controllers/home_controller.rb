class HomeController < ApplicationController
  def index
  	@states = State.order(:name) unless request.xhr?
  	state_id = @website.state_id
  	if state_id.nil?
  		@agencies = Agency.includes(judicial_districts: [:state]).where("states.id = ?", state_id).page(params[:page]).per(10).order(:organisation_name)
   else
  		@agencies = Agency.includes(judicial_districts: [:state]).page(params[:page]).per(10).order(:organisation_name)
   end
   
  end
end
