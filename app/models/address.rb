# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street           :string(255)
#  city             :string(255)
#  postcode         :integer
#  state            :string(255)
#  latitude         :float
#  longitude        :float
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :postcode, :street, :city, :state, :addressable_id
  validates_presence_of :city
  ## , :state - comment out state presence validation for now, jobadder missing state
  has_many :jobs

  geocoded_by :full_street_address do |obj, results|
  	if geo = results.first
  		obj.latitude = geo.latitude
  		obj.longitude = geo.longitude
  	else
  		results = Geocoder.coordinates(obj.state)
  		unless results.blank?
	  		obj.latitude = results[0]
	  		obj.longitude = results[1]
	  	end
  	end
  end

  include PgSearch
  pg_search_scope :address_has, against: [:street, :city, :state]

  after_validation :geocode, if: :full_street_address_changed?

  def full_street_address
    [street, city, postcode, state].compact.join(', ')
  end

  def full_street_address_changed?
    street_changed? || city_changed? || postcode_changed? || state_changed?
  end
end
