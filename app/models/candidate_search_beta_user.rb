# == Schema Information
#
# Table name: candidate_search_beta_users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CandidateSearchBetaUser < ActiveRecord::Base
  attr_accessible :email, :name
  validates_presence_of :name
  validates_presence_of :email
end
