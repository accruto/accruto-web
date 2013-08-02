require 'spec_helper'

feature 'Job Subcategory Management' do
	context "admin successfully" do
		scenario 'creates a new subcategory with valid fields'
		scenario 'updates a new subcategory with valid fields'
		scenario 'deletes a new subcategory with valid fields'
	end

	context "admin fails to" do
		scenario 'create a new subcategory with without a name'
		scenario 'update a new subcategory with without a name'
	end
end