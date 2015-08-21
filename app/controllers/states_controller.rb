class StatesController < ApplicationController

  def show
  	@state = State.find_by(slug: params[:id])
    set_default_values
	  @agencies = Agency.joins(judicial_districts: [:state]).where("states.id = ?", @state.id).page(params[:page]).per(15).order(:organisation_name)
  end

  def zip_codes
    @state = State.find_by(slug: params[:state_id])
    set_default_values
    @agencies = Agency.where("zip_code = ?", params[:zip_code]).page(params[:page]).per(15).order(:organisation_name)
    render :show
  end

  def cities
    @state = State.find_by(slug: params[:state_id])
    set_default_values
    @agencies = Agency.where("city = ?", params[:city]).page(params[:page]).per(15).order(:organisation_name)
    render :show
  end

  private

  def set_default_values
    unless request.xhr?
      state_ids = Agency.select("distinct state_id")
      @states = State.where(id: state_ids).order(:name) 
      filtered_infos = Agency.select("zip_code, city").where("state_id = ?", @state.id)
      @zip_codes = filtered_infos.collect(&:zip_code)
      @cities = filtered_infos.collect(&:city)
      @judicial_districts = JudicialDistrict.where(state_id: @state.id)
    end
  end

end
