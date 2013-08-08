class AddSlugToJobSubcategories < ActiveRecord::Migration
  def change
    add_column :job_subcategories, :slug, :string
    add_index :job_subcategories, :slug, unique: true
  end
end
