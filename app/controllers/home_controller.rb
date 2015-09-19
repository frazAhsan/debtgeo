class HomeController < ApplicationController
  def index
  	unless request.xhr?
  		state_ids = Agency.select("distinct state_id")
  		@states = State.where(id: state_ids).order(:name) 
  	end
  	state_id = @site.state_id
  	if state_id.nil?
  		@agencies = Agency.includes(:service_methods).joins(judicial_districts: [:state]).where("states.id = ?", state_id).page(params[:page]).per(15).order(:organisation_name).distinct
   else
  		@agencies = Agency.includes(:service_methods).includes(judicial_districts: [:state]).page(params[:page]).per(15).order(:organisation_name).distinct
   end
   
  end
end
