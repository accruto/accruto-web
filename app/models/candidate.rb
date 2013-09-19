class Candidate < ActiveRecord::Base
  attr_accessible :address_id, :first_name, :job_title, :last_name,
                  :phone, :status, :visa, :minimum_annual_salary
  validates :first_name, :last_name, :job_title, :status, :visa, :minimum_annual_salary, presence: true
  belongs_to :address

  STATUS  = [
              "Immediately available",
              "Actively looking",
              "Happy to talk"
            ]

  VISA    = [
              "Australian Citizen/Resident",
              "Valid work visa",
              "Waiting for a visa",
              "Need a work visa"
            ]
end
