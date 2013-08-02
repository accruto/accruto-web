require 'spec_helper'

feature 'Job Category Management' do
	context "admin successfully" do
		scenario 'creates a new category with valid fields'
		scenario 'updates a new category with valid fields'
		scenario 'deletes a new category with valid fields'
	end

	context "admin fails to" do
		scenario 'create a new category with without a name'
		scenario 'update a new category with without a name'
	end
end