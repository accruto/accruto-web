class Job < ActiveRecord::Base
  attr_accessible :address_id, :company_id, :expires_at, :external_link, :posted_at, :title, :type
end
