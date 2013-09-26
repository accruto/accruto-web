# == Schema Information
#
# Table name: preferences
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  email_frequency :string(255)      default("Daily")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  next_alert_date :date
#

class Preference < ActiveRecord::Base
  attr_accessible :user_id, :email_frequency, :next_alert_date

  belongs_to :user

  EMAIL_FREQUENCY = %w(Never Daily Weekly Fortnightly)
end
