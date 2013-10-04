class CreateJobSubcategoriesCandidates < ActiveRecord::Migration
  def change
    create_table :job_subcategories_candidates do |t|
      t.references :candidate
      t.references :job_subcategory

      t.timestamps
    end
    add_index :job_subcategories_candidates, :candidate_id
    add_index :job_subcategories_candidates, :job_subcategory_id
  end
end
