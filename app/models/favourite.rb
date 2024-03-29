# == Schema Information
#
# Table name: favourites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  job_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favourite < ActiveRecord::Base
  attr_accessible :job_id, :user_id

  belongs_to :job
  belongs_to :user
end
