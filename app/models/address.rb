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
  validates_presence_of :postcode, :city, :state
  belongs_to :addressable, polymorphic: true
end
