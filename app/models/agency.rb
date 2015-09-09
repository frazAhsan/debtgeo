class Agency < ActiveRecord::Base
	has_many :service_methods
	has_many :judicial_district_agencies
  	has_many :judicial_districts, through: :judicial_district_agencies
  	has_many :providers, class_name: "BbbOverview"


   def display_slug
      return "#{self.organisation_name.gsub(" ", "-").gsub(/[^0-9a-z]/i, '-').downcase rescue ""}"
  end
end
