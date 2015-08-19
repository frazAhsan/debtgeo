class State < ActiveRecord::Base
  validates :state_code, uniqueness: true
  has_many :judicial_districts
  extend FriendlyId
  friendly_id :name, use: :slugged
end
