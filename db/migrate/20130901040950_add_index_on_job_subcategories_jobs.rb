class AddIndexOnJobSubcategoriesJobs < ActiveRecord::Migration
  def change
    add_index :job_subcategories_jobs, :job_subcategory_id
    add_index :job_subcategories_jobs, :job_id
  end
end
