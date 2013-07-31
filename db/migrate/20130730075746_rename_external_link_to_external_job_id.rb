class RenameExternalLinkToExternalJobId < ActiveRecord::Migration
  def up
  	rename_column :jobs, :external_link, :external_job_id
  end

  def down
  	rename_column :jobs, :external_job_id, :external_job_link
  end
end
