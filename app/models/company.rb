# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  logo_url   :string(255)
#

class Company < ActiveRecord::Base
  attr_accessible :name, :phone

  validates :name, presence: true,
                   uniqueness: true

  has_many :jobs
end
