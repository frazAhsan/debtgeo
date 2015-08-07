class JudicialDistrictAgency < ActiveRecord::Base
	belongs_to :judicial_district
	belongs_to :agency
end
