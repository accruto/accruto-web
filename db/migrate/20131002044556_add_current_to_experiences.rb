class AddCurrentToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :current, :boolean
  end
end
