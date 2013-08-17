# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :favourites
  has_many :favourite_jobs, through: :favourites, :source => :job
  has_many :recent_searches
  has_many :preferences

  def favourite_job?(job_id)
    favourites.map(&:job_id).include?(job_id.to_i)
  end

  def collect_jobs_results
    collected_jobs = []
    self.recent_searches.each do |recent_search|
      ## get latest search result and compare with existing saved result
      latest_job_ids = Job.grab_search_results(recent_search).map(&:id)
      current_job_ids = recent_search.search_results.map {|r| r.keys[0] }
      new_jobs_ids = latest_job_ids - current_job_ids

      ## update recent_search search_results if there is any diff
      new_jobs_ids.each do |new_jobs_id|
        recent_search.search_results << { new_jobs_id => { notified: false } }
        recent_search.save
      end

      ## get only job that not yet received by user (notified == false)
      jobs_ids = []
      recent_search.search_results.each do |result|
        if result.values.first[:notified] == false
          jobs_ids << result.keys.first
        end
      end

      ## grab latest job from
      jobs = Job.find(jobs_ids)
      jobs.each do |job|
        collected_jobs << job
      end
    end
    collected_jobs
  end

  def update_job_results(status)
    self.recent_searches.each do |recent_search|
      recent_search.search_results.each do |result|
        result[result.keys.first][:notified] = status
      end
      recent_search.save
    end
  end
end
