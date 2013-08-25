class AddExternalIds < ActiveRecord::Migration
  def change
    add_column :job_categories, :external_category_ids, :text
    add_column :job_subcategories, :external_subcategory_ids, :text
  end
end
