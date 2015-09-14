class State < ActiveRecord::Base
  validates :state_code, uniqueness: true
  has_many :judicial_districts

  before_save :set_display_slug
  def set_display_slug
      self.slug = self.name.gsub(" ", "-").gsub(/[^0-9a-z]/i, '-').squeeze("-").downcase rescue ""
  end
end
