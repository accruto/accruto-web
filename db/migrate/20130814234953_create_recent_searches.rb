class CreateRecentSearches < ActiveRecord::Migration
  def change
    create_table :recent_searches do |t|
      t.string :job_title
      t.string :address
      t.string :days
      t.string :sort
      t.string :category
      t.references :user
      t.datetime :search_at
      t.text :source

      t.timestamps
    end
    add_index :recent_searches, :user_id
  end
end
