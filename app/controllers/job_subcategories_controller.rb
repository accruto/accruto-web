class JobsubcategoriesController < ApplicationController
	def show
		@subcategory = JobSubcategory.find(params[:id])
	end
end