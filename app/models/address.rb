# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  unit             :string(255)
#  street           :string(255)
#  postcode         :integer
#  latitude         :string(255)
#  longitude        :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Address < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :postcode, :street, :unit, :addressable_id
  validates_presence_of :unit, :street, :postcode
  belongs_to :addressable, polymorphic: true
end
