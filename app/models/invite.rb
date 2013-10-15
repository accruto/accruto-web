class Invite < ActiveRecord::Base
  attr_accessible :email, :message, :name, :user_id, :status
  belongs_to :user

  validates :email, :name, presence: true
  validates_uniqueness_of :email, message: "This friend has already been invited"

  state_machine :status, :initial => :invited do
    event :signed_up do
      transition all => :signed_up
    end

    state :invited
    state :signed_up
  end

  def self.signed_up_count
    return Invite.where(:status => "signed_up").count
  end
end
