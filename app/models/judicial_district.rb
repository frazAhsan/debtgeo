class JudicialDistrict < ActiveRecord::Base
	belongs_to :state
	has_many :judicial_district_agencies
  	has_many :agencies, through: :judicial_district_agencies

  	def slug
  		name = self.name.downcase.gsub(" ", "-").squeeze("-").downcase
  		return "#{name}"
  	end
end
