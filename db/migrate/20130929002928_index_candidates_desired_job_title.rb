class IndexCandidatesDesiredJobTitle < ActiveRecord::Migration
  def up
    execute "CREATE INDEX candidates_desired_job_title ON candidates USING GIN(desired_job_title)"
  end

  def down
    execute "DROP INDEX candidates_desired_job_title"
  end
end
