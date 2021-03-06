class BbbOverview < ActiveRecord::Base
	belongs_to :agency
	has_many :bbb_complaints
  has_many :bbb_contacts
  
  after_save :set_display_slug

  #validates :display_slug, uniqueness: true

  def set_display_slug
    slug = ("#{self.name}-#{self.locality}-#{self.region}-#{self.id}".gsub(" ", "-").gsub(/[^0-9a-z]/i, '-').squeeze("-").downcase rescue "")
    self.update_column(:display_slug, slug)
  end

  	def accredited_since_title
  		begin
  			return "BBB ACCREDITED BUSINESS SINCE #{Date.new(date_ar[2].to_i, date_ar[0].to_i, date_ar[1].to_i).strftime("%m/%d/%Y")}".upcase
  		rescue
  			return "This provider is not bbb accredited".upcase
  		end
  	end

    def address
      [street_address, locality, region, postal_code].reject(&:blank?).reject(&:nil?).join(", ")
    end
end
