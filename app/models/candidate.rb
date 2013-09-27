# == Schema Information
#
# Table name: candidates
#
#  id                    :integer          not null, primary key
#  first_name            :string(255)
#  last_name             :string(255)
#  phone                 :string(255)
#  status                :string(255)
#  job_title             :string(255)
#  address_id            :integer
#  visa                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  minimum_annual_salary :integer
#  user_id               :integer
#

class Candidate < ActiveRecord::Base
  include PgSearch
  mount_uploader :profile_photo, ProfilePhotoUploader

  attr_accessible :address_id, :user_id, :first_name, :job_title, :last_name,
                  :phone, :status, :visa, :minimum_annual_salary, :updated_at,
                  :profile_photo
  validates :first_name, :last_name, :job_title, :status, :visa, :minimum_annual_salary, presence: true
  belongs_to :address
  belongs_to :user

  scope :search_by_job_title, lambda { |title_keyword| _title_has(title_keyword) if title_keyword.present? }
  scope :filter_by_address, lambda { |address| joins(:address).where("addresses.city @@ :q or addresses.state @@ :q", q: address.downcase) if address.present? }
  scope :filter_by_updated_at, lambda { |days| where("updated_at >= ?", days.to_i.days.ago) if days.present? }
  scope :filter_by_status, lambda { |status| where("status = ?", status) if status.present? }
  scope :filter_by_visa, lambda { |visa| where("visa = ?", visa) if visa.present? }

  def self.filter_by_minimum_annual_salary(min, max)
    where(
      "minimum_annual_salary >= :min AND minimum_annual_salary <= :max", min: min.to_i, max: max.to_i
    )
  end

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
