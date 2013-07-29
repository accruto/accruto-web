class CreateJobSubcategories < ActiveRecord::Migration
  def change
    create_table :job_subcategories do |t|
      t.string :name
      t.integer :job_category_id

      t.timestamps
    end
  end
end
