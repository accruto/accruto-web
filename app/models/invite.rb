class Invite < ActiveRecord::Base
  attr_accessible :email, :message, :name, :user_id, :status
  belongs_to :user

  state_machine :status, :initial => :invited do
    event :signed_up do
      transition all => :signed_up
    end

    state :invited
    state :signed_up
  end
end
