class AddSearchIndexToAddresses < ActiveRecord::Migration
  def up
  	execute "create index address_street on addresses using gin(to_tsvector('simple', street))"
  	execute "create index address_city on addresses using gin(to_tsvector('simple', city))"
  	execute "create index address_state on addresses using gin(to_tsvector('simple', state))"
  end

  def down
  	execute "drop index address_street"
    execute "drop index address_city"
    execute "drop index address_state"
  end
end
