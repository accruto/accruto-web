require 'spec_helper'

describe ApiController do

  describe "GET 'jobs'" do
    it "returns http success" do
      get 'jobs'
      response.should be_success
    end
  end

end
