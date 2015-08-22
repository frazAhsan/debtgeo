class ServiceMethod < ActiveRecord::Base
	belongs_to :agency

	def in_person_address
		[location_address_street_address1, location_address_street_address2, location_address_city, location_address_state_code, location_address_postal_code, location_address_phone_number].reject(&:blank?).join(", ")
	end

end
