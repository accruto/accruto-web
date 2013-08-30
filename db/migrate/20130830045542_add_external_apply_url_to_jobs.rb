class AddExternalApplyUrlToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :external_apply_url, :string
  end
end
