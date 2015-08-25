class StatesController < ApplicationController

  def show
  	@state = State.find_by(slug: params[:id])
    set_default_values
	  @agencies = Agency.includes(:service_methods).joins(judicial_districts: [:state]).where("states.id = ?", @state.id).page(params[:page]).per(15).order(:organisation_name).distinct
  end

  def zip_codes
    @state = State.find_by(slug: params[:id])
    set_default_values
    @agencies = Agency.includes(:service_methods).where("zip_code = ?", params[:zip_code]).page(params[:page]).per(15).order(:organisation_name).distinct
    render :show
  end

  def search
    attribute = params[:attribute].gsub("-", " ")
    @state = State.find_by(slug: params[:id])
    set_default_values
    if params[:attribute].include?("-county")
      @agencies = Agency.includes(:service_methods).where("lower(county) = ?", attribute).page(params[:page]).per(15).order(:organisation_name).distinct
    else
      @agencies = Agency.includes(:service_methods).where("lower(city) = ?", attribute).page(params[:page]).per(15).order(:organisation_name).distinct
    end
    render :show
    
  end


  private

  def set_default_values
    unless request.xhr?
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
