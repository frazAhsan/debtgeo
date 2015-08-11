class JudicialDistrict < ActiveRecord::Base
	belongs_to :state
	has_many :judicial_district_agencies
  	has_many :agencies, through: :judicial_district_agencies
end
