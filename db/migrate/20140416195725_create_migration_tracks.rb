class CreateMigrationTracks < ActiveRecord::Migration
  def change
    create_table :migration_tracks do |t|
      t.string :last_data_time
      t.string :email

      t.timestamps
    end
  end
end
