class CreateJobSubcategoriesJobs < ActiveRecord::Migration
	def change
		create_table :job_subcategories_jobs do |t|
			t.belongs_to :job_subcategory
			t.belongs_to :job
		end
	end
end
