# == Schema Information
#
# Table name: recent_searches
#
#  id             :integer          not null, primary key
#  job_title      :string(255)
#  address        :string(255)
#  days           :string(255)
#  sort           :string(255)
#  category       :string(255)
#  user_id        :integer
#  search_at      :datetime
#  source         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  subscribed     :boolean          default(FALSE)
#  search_results :text
#

require 'spec_helper'

describe RecentSearch do
  before :each do
    @recent_search = create(:recent_search)
  end

  context "valid recent search" do
    it "has a valid recent search" do
      expect(@recent_search).to be_valid
    end

    it "has a valid user recent search" do
      expect(@recent_search.user_id).to eq(100)
    end

    it "has a valid recent search update job_title" do
      @recent_search.job_title = 'PHP Developer'
      @recent_search.save
      expect(@recent_search.job_title).to eq('PHP Developer')
    end

    it "has a valid recent search update address" do
      @recent_search.address = 'Melbourne'
      @recent_search.save
      expect(@recent_search.address).to eq('Melbourne')
    end
  end
end
