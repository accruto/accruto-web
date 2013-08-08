class AddSlugToJobCategories < ActiveRecord::Migration
  def change
    add_column :job_categories, :slug, :string
    add_index :job_categories, :slug, unique: true
  end
end
