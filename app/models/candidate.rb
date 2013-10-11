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
#  profile_photo         :string(255)
#  summary               :text
#

class Candidate < ActiveRecord::Base
  include PgSearch

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :skills, :positions

  mount_uploader :profile_photo, ProfilePhotoUploader
  serialize :desired_job_title, ActiveRecord::Coders::Hstore

  attr_accessible :address_id, :user_id, :first_name, :job_title, :last_name,
                  :phone, :status, :visa, :minimum_annual_salary, :updated_at,
                  :profile_photo, :resume_attributes, :summary, :desired_job_title, :email,
                  :experiences_attributes, :trade_qualifications_attributes, :educations_attributes, :skills, :state, :positions,
                  :subcategories_attributes, :start_interviewing_at

  attr_writer :email, :skills, :positions

  validates :first_name, :last_name, presence: true
  validates :minimum_annual_salary, presence: {message: 'Please fill in your minimum annual salary'}, unless: :validate_new_record
  validates :visa, presence: {message: 'Please fill in your visa'}, unless: :validate_new_record
  validates :status, presence: {message: 'Please fill in your status'}, unless: :validate_new_record

  # validates :first_name, uniqueness: {scope: [:last_name, :job_title]}

  belongs_to :address
  belongs_to :user

  has_many :experiences, dependent: :destroy
  has_many :trade_qualifications, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :job_subcategories_candidates
  has_many :subcategories, through: :job_subcategories_candidates, source: :job_subcategory

  accepts_nested_attributes_for :subcategories, reject_if: lambda { |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :educations, reject_if: lambda { |a| a[:institution].blank? }, allow_destroy: true
  accepts_nested_attributes_for :trade_qualifications, reject_if: lambda { |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :experiences, reject_if: lambda { |a| a[:company].blank? && a[:job_title].blank? }, allow_destroy: true

  scope :search_by_job_title, lambda { |title_keyword| _title_has(title_keyword) if title_keyword.present? }
  scope :filter_by_address, lambda { |address| joins(:address).where("addresses.city @@ :q or addresses.state @@ :q", q: address.downcase) if address.present? }
  scope :filter_by_updated_at, lambda { |days| where("updated_at >= ?", days.to_i.days.ago) if days.present? }
  scope :filter_by_status, lambda { |status| where("status = ?", status) if status.present? }
  scope :filter_by_visa, lambda { |visa| where("visa = ?", visa) if visa.present? }

  STATUS_OPTIONS = [
    "Immediately",
    "Within One Week",
    "Within One Month",
    "After One Month",
  ]

  START_INTERVIEWING_AT_OPTIONS = {
    "After 6 months" => 6.months.from_now,
    "After 1 month" => 1.month.from_now,
    "After 1 week" => 1.week.from_now,
    "Immediately" => DateTime.now
  }

  VISA_OPTIONS = [
    "Australian Residency or Citizenship",
    "Valid Work Visa",
    "No Work Visa"
  ]

  BOUNTY = "$858"

  state_machine :state, :initial => :unpublished do
    event :publish do
      transition all => :publish
    end

    event :unpublish do
      transition all => :unpublished
    end

    state :publish
    state :unpublish
  end

  def self.filter_by_minimum_annual_salary(min, max)
    where(
      "minimum_annual_salary >= :min AND minimum_annual_salary <= :max", min: min.to_i, max: max.to_i
    )
  end

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  def email
    @email || (user ? user.email : nil)
  end

  def email=(email_value)
    user.email = email_value if email_value.present?
    user.save if user.email_changed?
  end

  def skills=(lists)
    self.skill_list = lists
  end

  def self.set_default_unpublished
    candidates = where("state IS NULL")
    candidates.each {|candidate| candidate.unpublish! }
  end

  def positions=(lists)
    lists.split(",").each { |category| JobSubcategory.find_or_create_by_name(category) }
    self.position_list = lists
  end

  private
    pg_search_scope :_title_has, against: :job_title,
    using: {
        tsearch: {
          dictionary: "english",
        }
    }

    def validate_new_record
      self.new_record?
    end
end
