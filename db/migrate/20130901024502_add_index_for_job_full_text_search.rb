class AddIndexForJobFullTextSearch < ActiveRecord::Migration
  def up
    execute "ALTER TABLE jobs ADD COLUMN tsv tsvector"
    execute <<-QUERY
    UPDATE jobs SET tsv = (to_tsvector('english', coalesce("jobs"."title"::text, '')) ||
                           to_tsvector('english', coalesce("jobs"."description"::text, '')));
    QUERY

    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
              ON jobs FOR EACH ROW EXECUTE PROCEDURE
              tsvector_update_trigger(tsv, 'pg_catalog.english', title, description);"
  end
  def down
    execute "drop trigger tsvectorupdate on jobs"
    execute "alter table jobs drop column tsv"
  end
end
