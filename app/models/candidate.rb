class Candidate < ActiveRecord::Base
  include PgSearch

  attr_accessible :address_id, :first_name, :job_title, :last_name,
                  :phone, :status, :visa, :minimum_annual_salary
  validates :first_name, :last_name, :job_title, :status, :visa, :minimum_annual_salary, presence: true
  belongs_to :address

  scope :search_by_job_title, lambda { |title_keyword| _title_has(title_keyword) if title_keyword.present? }
  scope :filter_by_address, lambda { |address| joins(:address).where("addresses.city @@ :q or addresses.state @@ :q", q: address.downcase) if address.present? }
  scope :filter_by_days, lambda { |days| where("updated_at >= ?", days.to_i.days.ago) if days.present? }

  STATUS  = [
              "Immediately available",
              "Actively looking",
              "Happy to talk"
            ]

  VISA    = [
              "Australian Resident",
              "Valid work visa",
              "No work visa"
            ]

  private
    pg_search_scope :_title_has, against: :job_title,
    using: {
        tsearch: {
          dictionary: "english",
        }
    }
end
