class Agency < ActiveRecord::Base
	has_many :service_methods
	has_many :judicial_district_agencies
  	has_many :judicial_districts, through: :judicial_district_agencies
end
