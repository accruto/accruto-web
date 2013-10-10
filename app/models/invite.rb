class Invite < ActiveRecord::Base
  attr_accessible :email, :message, :name, :user_id, :status
  belongs_to :user
  before_save :set_default_status

  def set_default_status
    self.status = 'invited'
  end
end
