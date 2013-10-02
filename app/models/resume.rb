# == Schema Information
#
# Table name: resumes
#
#  id                :integer          not null, primary key
#  candidate_id      :integer
#  courses           :text
#  awards            :text
#  skills            :text
#  objective         :text
#  summary           :text
#  other             :string(255)
#  citizenship       :string(255)
#  affiliations      :text
#  professional      :text
#  interests         :text
#  referees          :text
#  updated_at_linkme :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Resume < ActiveRecord::Base
  attr_accessible :affiliations, :awards, :candidate_id, :citizenship,
                  :courses, :interests, :objective, :other, :professional,
                  :referees, :skills, :summary, :updated_at_linkme
  belongs_to :candidate
end
