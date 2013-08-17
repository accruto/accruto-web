# == Schema Information
#
# Table name: recent_searches
#
#  id             :integer          not null, primary key
#  job_title      :string(255)
#  address        :string(255)
#  days           :string(255)
#  sort           :string(255)
#  category       :string(255)
#  user_id        :integer
#  search_at      :datetime
#  source         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  subscribed     :boolean          default(FALSE)
#  search_results :text
#

class RecentSearch < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :job_title, :search_at, :days, :sort, :category, :source, :user_id, :subscribed, :search_results

  serialize :source, Hash
  serialize :search_results, Array

  def activate_alert(search_job_ids)
    mapped_jobs = []
    search_job_ids.map { |job_id| mapped_jobs << { job_id => {notified: false} } }
    update_attributes(subscribed: true, search_results: mapped_jobs)
  end

  def inactivate_alert
    update_attributes(subscribed: false, search_results: [])
  end
end
