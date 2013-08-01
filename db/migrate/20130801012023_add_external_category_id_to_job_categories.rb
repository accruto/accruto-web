class AddExternalCategoryIdToJobCategories < ActiveRecord::Migration
  def change
    add_column :job_categories, :external_category_id, :integer
  end
end
