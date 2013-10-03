class AddDesiredJobTitleToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :desired_job_title, :hstore
  end
end
