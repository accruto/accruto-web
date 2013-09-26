class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.integer :candidate_id
      t.text :courses
      t.text :awards
      t.text :skills
      t.text :objective
      t.text :summary
      t.string :other
      t.string :citizenship
      t.text :affiliations
      t.text :professional
      t.text :interests
      t.text :referees
      t.datetime :updated_at_linkme

      t.timestamps
    end
  end
end
