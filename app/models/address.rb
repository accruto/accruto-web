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
  validates_presence_of :city, :state
  has_many :jobs

  geocoded_by :full_street_address do |obj, results|
  	if geo = results.first
  		obj.latitude = geo.latitude
  		obj.longitude = geo.longitude
  	else
  		results = Geocoder.coordinates(obj.state)
  		obj.latitude = results[0]
  		obj.longitude = results[1]
  	end
  end

  after_validation :geocode

  def full_street_address
    [street, city, postcode, state].compact.join(', ')
  end
end
