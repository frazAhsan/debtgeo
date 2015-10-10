class AgenciesController < ApplicationController

	def show
	  #id = params[:slug].split("-").last
	  @agency = Agency.find_by(display_slug: params[:slug])
    if @provider.nil?
      render file: "#{Rails.root}/public/404.html", status: 403, layout: false
    else
	     #@state = State.find_by(slug: params[:id])
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
