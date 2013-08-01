class AddExternalSubcategoryIdToJobSubcategories < ActiveRecord::Migration
  def change
    add_column :job_subcategories, :external_subcategory_id, :integer
  end
end
