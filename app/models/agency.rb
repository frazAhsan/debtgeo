class Agency < ActiveRecord::Base
	has_many :service_methods
	has_many :judicial_district_agencies
  	has_many :judicial_districts, through: :judicial_district_agencies
  	has_many :providers, class_name: "BbbOverview"


  after_save :set_display_slug

  #validates :display_slug, uniqueness: true

  def set_display_slug
    slug = ("#{self.organisation_name.gsub(" ", "-").gsub(/[^0-9a-z]/i, '-').squeeze("-").downcase rescue ""}")
    self.update_column(:display_slug, slug)
  end

end
