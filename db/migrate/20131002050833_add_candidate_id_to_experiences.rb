class AddCandidateIdToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :candidate_id, :integer
  end
end
