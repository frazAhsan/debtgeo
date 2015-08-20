class JudicialDistrict < ActiveRecord::Base
	belongs_to :state
	has_many :judicial_district_agencies
  	has_many :agencies, through: :judicial_district_agencies

  	def slug
  		state = self.try(:state).try(:name)
  		name = self.name.gsub(" ", "-")
  		return "#{self.id}-#{state}-#{name}"
  	end
end
