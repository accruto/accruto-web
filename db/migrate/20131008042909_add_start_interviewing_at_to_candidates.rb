class AddStartInterviewingAtToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :start_interviewing_at, :datetime
  end
end
