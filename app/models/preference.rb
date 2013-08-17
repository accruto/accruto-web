class Preference < ActiveRecord::Base
  attr_accessible :user_id, :email_frequency

  belongs_to :user

  EMAIL_FREQUENCY = %w(Daily Weekly Fortnightly)
end
