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
#  active                 :boolean
#

class User < ActiveRecord::Base
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :candidate_attributes
  # attr_accessible :title, :body

  has_many :favourites
  has_many :favourite_jobs, through: :favourites, :source => :job
  has_many :recent_searches
  has_one :preference
  has_many :job_applications

  before_create :set_default_preference
  after_create :assign_role

  has_one :candidate
  accepts_nested_attributes_for :candidate

  def favourite_job?(job_id)
    favourites.map(&:job_id).include?(job_id.to_i)
  end

  def collect_jobs_results
    self.recent_searches.each do |recent_search|
      puts "  Process recent_search for '#{recent_search.job_title}'".green
      puts "    Get latest search result and compare with existing saved result"
      start = Time.now
      latest_job_ids = Job.grab_search_results(recent_search).map(&:id)
      current_job_ids = recent_search.search_results.map {|r| r.keys[0] }
      new_jobs_ids = latest_job_ids - current_job_ids
      puts "    Time elapsed: #{Time.now - start} seconds".yellow

      if new_jobs_ids.size > 0
        puts "    Update recent_search.search_results if there is any diff"
        start = Time.now
        mapped_jobs = []
        (current_job_ids + new_jobs_ids).map { |job_id| mapped_jobs << { job_id => {notified: false} } }
        recent_search.update_attribute(:search_results, mapped_jobs)
        puts "    Time elapsed: #{Time.now - start} seconds".yellow
      else
        puts "    No jobs diff"
      end

      puts "    Get only job that not yet received by user (notified == false)"
      start = Time.now
      jobs_ids = []
      recent_search.search_results.each do |result|
        if result.values.first[:notified] == false
          jobs_ids << result.keys.first
        end
      end
      puts "      #{jobs_ids.size} jobs to process"
      puts "    Time elapsed: #{Time.now - start} seconds".yellow

      puts "    Get job data #{jobs_ids.to_s}"
      start = Time.now
      jobs = Job.find(jobs_ids)
      puts "    Time elapsed: #{Time.now - start} seconds".yellow
      unless jobs.empty?
        puts "  Send mailer process to background\n".green
        Delayed::Job.enqueue JobMailerWorker.new({ user: self, jobs: jobs}), :queue => 'job-alert-email'
      end
    end
  end

  def update_job_results(status)
    self.recent_searches.each do |recent_search|
      recent_search.search_results.each do |result|
        result[result.keys.first][:notified] = status
      end
      recent_search.save
    end

    next_alert = if preference.email_frequency == 'Daily'
      1.day.from_now.to_date
    elsif preference.email_frequency == 'Weekly'
      1.week.from_now.to_date
    elsif preference.email_frequency == 'Fortnightly'
      2.weeks.from_now.to_date
    end

    preference.update_attributes!(:next_alert_date => next_alert)
  end

  def self.job_alert_subscribed
    joins(:preference).where("preferences.next_alert_date = ? AND preferences.email_frequency != 'Never'", Date.today)
  end

  private

  def set_default_preference
    build_preference(email_frequency: 'Daily', next_alert_date: Date.today)
  end

  def assign_role
    if self.candidate
      self.add_role :candidate
      #add role recruiter
    end
  end
end
