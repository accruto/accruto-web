class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :resume
      t.integer :user_id
      t.integer :job_id
      t.boolean :accepted_terms

      t.timestamps
    end
  end
end
