class Shortlist < ActiveRecord::Base
  attr_accessible :candidate_id, :user_id

  belongs_to :candidate
  belongs_to :user

  validates :candidate_id, presence: true, uniqueness: {scope: :user_id}
end
