class Profile
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :first_name
  attr_reader :last_name
  attr_reader :job_title
  attr_reader :phone
  attr_reader :summary
  attr_reader :status
  attr_reader :visa
  attr_reader :minimum_annual_salary


  attribute :first_name, String
  attribute :last_name, String
  attribute :job_title, String
  attribute :phone, String
  attribute :summary, String
  attribute :status, String
  attribute :visa, String
  attribute :minimum_annual_salary, Integer

  validates :first_name, :last_name, :job_title, :phone, :status,
            :visa, :minimum_annual_salary, presence: true

  def persisted?
    false
  end

  def save(params)
    if valid?
      persist(params)
      true
    else
      false
    end
  end

  private
    def persist(params)
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
      @candidate = Candidate.find_or_initialize_by_user_id(user_id: params.id)
      @candidate.attributes = candidate_attributes
      @candidate.save!
    end
end