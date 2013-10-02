class Profile
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :first_name
  attr_reader :last_name
  attr_reader :email
  attr_reader :job_title
  attr_reader :phone
  attr_reader :summary
  attr_reader :status
  attr_reader :visa
  attr_reader :minimum_annual_salary

  attr_reader :experience_company
  attr_reader :experience_job_title
  attr_reader :experience_started_at
  attr_reader :experience_ended_at
  attr_reader :experience_current

  attr_reader :trade_qualification_name
  attr_reader :trade_qualification_attained_at

  attr_reader :education_institution
  attr_reader :education_qualification
  attr_reader :education_qualification_type
  attr_reader :education_graduated_at

  attribute :first_name, String
  attribute :last_name, String
  attribute :email, String
  attribute :job_title, String
  attribute :phone, String
  attribute :summary, String
  attribute :status, String
  attribute :visa, String
  attribute :minimum_annual_salary, Integer

  attribute :experience_company, String
  attribute :experience_job_title, String
  attribute :experience_started_at, DateTime
  attribute :experience_ended_at, DateTime
  attribute :experience_current, Boolean

  attribute :trade_qualification_name, String
  attribute :trade_qualification_attained_at, DateTime

  attribute :education_institution, String
  attribute :education_qualification, String
  attribute :education_qualification_type, String
  attribute :education_graduated_at, DateTime

  validates :first_name, :last_name, :email, :job_title, :phone, :status,
            :visa, :minimum_annual_salary, presence: true

  def experience_started_at_in_years
    experience_started_at.strftime('%Y') if experience_started_at.present?
  end

  def experience_started_at_in_years=(years)
    self.experience_started_at = Date.strptime(years, "%Y").to_s(:db) if years.present?
  end

  def experience_ended_at_in_years
    experience_ended_at.strftime('%Y') if experience_ended_at.present?
  end

  def experience_ended_at_in_years=(years)
    self.experience_ended_at = Date.strptime(years, "%Y").to_s(:db) if years.present?
  end

  def trade_qualification_attained_at_in_years
    trade_qualification_attained_at.strftime('%Y') if trade_qualification_attained_at.present?
  end

  def trade_qualification_attained_at_in_years=(years)
    self.trade_qualification_attained_at = Date.strptime(years, "%Y").to_s(:db) if years.present?
  end

  def education_graduated_at_in_years
    education_graduated_at.strftime('%Y') if education_graduated_at.present?
  end

  def education_graduated_at_in_years=(years)
    self.education_graduated_at = Date.strptime(years, "%Y").to_s(:db) if years.present?
  end

  def persisted?
    false
  end

  def save(params)
    if valid?
      persist!(params)
      true
    else
      false
    end
  end

  private
    def persist!(params)
      candidate_attributes = {
        first_name: first_name,
        last_name: last_name,
        job_title: job_title,
        phone: phone,
        summary: summary,
        status: status,
        visa: visa,
        minimum_annual_salary: minimum_annual_salary
      }

      experience_attributes = {
        company: experience_company,
        job_title: experience_job_title,
        started_at: experience_started_at,
        ended_at: experience_ended_at,
        current: experience_current
      }

      trade_qualification_attributes = {
        name: trade_qualification_name,
        attained_at: trade_qualification_attained_at
      }

      education_attributes = {
        institution: education_institution,
        qualification: education_qualification,
        qualification_type: education_qualification_type,
        graduated_at: education_graduated_at
      }

      @candidate = Candidate.find_or_initialize_by_user_id(user_id: params.id)
      @candidate.attributes = candidate_attributes
      @candidate.save!

      @user = User.find_or_initialize_by_id(id: params.id)
      @user.email = email
      @user.save!

      @experience = Experience.find_or_initialize_by_candidate_id(candidate_id: @candidate.id)
      @experience.attributes = experience_attributes
      @experience.save!

      @trade_qualification = TradeQualification.find_or_initialize_by_candidate_id(candidate_id: @candidate.id)
      @trade_qualification.attributes = trade_qualification_attributes
      @trade_qualification.save!

      @education = Education.find_or_initialize_by_candidate_id(candidate_id: @candidate.id)
      @education.attributes = education_attributes
      @education.save!
    end
end