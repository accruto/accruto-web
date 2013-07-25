class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :address_id
      t.datetime :posted_at
      t.datetime :expires_at
      t.string :type
      t.integer :company_id
      t.string :external_link

      t.timestamps
    end
  end
end
