class AddCandidateIdToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :candidate_id, :integer
  end
end
