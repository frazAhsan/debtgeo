class Website < ActiveRecord::Base
	validates :domain, uniqueness: true	
	validates :name, :domain, :city, :state_id, presence: true

	belongs_to :state
end
