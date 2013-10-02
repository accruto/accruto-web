class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :company
      t.string :job_title
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
