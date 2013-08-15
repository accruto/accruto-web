# == Schema Information
#
# Table name: recent_searches
#
#  id         :integer          not null, primary key
#  job_title  :string(255)
#  address    :string(255)
#  days       :string(255)
#  sort       :string(255)
#  category   :string(255)
#  user_id    :integer
#  search_at  :datetime
#  source     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecentSearch < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :job_title, :search_at, :days, :sort, :category, :source, :user_id

  serialize :source, Hash
end
