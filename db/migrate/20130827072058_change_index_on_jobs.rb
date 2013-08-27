class ChangeIndexOnJobs < ActiveRecord::Migration
  def change
    execute "DROP INDEX index_jobs_on_description"
    execute "CREATE INDEX index_jobs_on_description ON jobs USING GIN(to_tsvector('english', description))"
  end
end
