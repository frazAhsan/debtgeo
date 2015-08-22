class StatesController < ApplicationController

  def show
  	@state = State.find_by(slug: params[:id])
    set_default_values
	  @agencies = Agency.includes(:service_methods).joins(judicial_districts: [:state]).where("states.id = ?", @state.id).page(params[:page]).per(15).order(:organisation_name).distinct
  end

  def zip_codes
    @state = State.find_by(slug: params[:state_id])
    set_default_values
    @agencies = Agency.includes(:service_methods).where("zip_code = ?", params[:zip_code]).page(params[:page]).per(15).order(:organisation_name).distinct
    render :show
  end

  def cities
    @state = State.find_by(slug: params[:state_id])
    set_default_values
    @agencies = Agency.includes(:service_methods).where("city = ?", params[:city]).page(params[:page]).per(15).order(:organisation_name).distinct
    render :show
  end

  def counties
    @state = State.find_by(slug: params[:state_id])
    set_default_values
    @agencies = Agency.includes(:service_methods).where("county = ?", params[:county]).page(params[:page]).per(15).order(:organisation_name).distinct
    render :show
  end

  private

  def set_default_values
    unless request.xhr?
      state_ids = Agency.select("distinct state_id")
      @states = State.where(id: state_ids).order(:name) 
      filtered_infos = Agency.select("zip_code, city, county").where("state_id = ?", @state.id)
      @zip_codes = filtered_infos.collect(&:zip_code)
      @cities = filtered_infos.collect(&:city)
      @counties = filtered_infos.collect(&:county)
      @judicial_districts = JudicialDistrict.where(state_id: @state.id)
    end
  end

end
