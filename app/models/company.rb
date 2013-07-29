# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  attr_accessible :name, :phone, :address_attributes
  validates_presence_of :name, :phone, :address
  has_one :address, as: :addressable
  has_many :jobs

  accepts_nested_attributes_for :address
end
