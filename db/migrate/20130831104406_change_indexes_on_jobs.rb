class ChangeIndexesOnJobs < ActiveRecord::Migration
  def up
    execute "DROP INDEX IF EXISTS index_jobs_on_title"
    execute "CREATE INDEX jobs_title ON jobs USING GIN(to_tsvector('english', title))"
    execute "DROP INDEX IF EXISTS index_jobs_on_description"
    execute "CREATE INDEX jobs_description ON jobs USING GIN(to_tsvector('english', description))"
    execute "CREATE INDEX job_subcategories_name ON job_subcategories USING GIN(to_tsvector('english', name))"
    execute "CREATE INDEX addresses_street ON addresses USING GIN(to_tsvector('english', street))"
    execute "CREATE INDEX addresses_city ON addresses USING GIN(to_tsvector('english', city))"
    execute "CREATE INDEX addresses_state ON addresses USING GIN(to_tsvector('english', state))"
  end

  def down
    execute "DROP INDEX IF EXISTS jobs_title"
    execute "CREATE INDEX index_jobs_on_title ON jobs USING GIN(to_tsvector('english', title))"
    execute "DROP INDEX IF EXISTS jobs_description"
    execute "CREATE INDEX index_jobs_on_description ON jobs USING GIN(to_tsvector('english', description))"
    execute "DROP INDEX IF EXISTS job_subcategories_name"
    execute "DROP INDEX IF EXISTS addresses_street"
    execute "DROP INDEX IF EXISTS addresses_city"
    execute "DROP INDEX IF EXISTS addresses_state"
  end
end
