class State < ActiveRecord::Base
  has_many :judicial_districts
  extend FriendlyId
  friendly_id :name, use: :slugged
end
