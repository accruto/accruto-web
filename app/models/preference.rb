class Preference < ActiveRecord::Base
  attr_accessible :user_id, :email_frequency, :next_alert_date

  belongs_to :user

  EMAIL_FREQUENCY = %w(Never Daily Weekly Fortnightly)
end
