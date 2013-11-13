class AddPublishedAtToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :published_at, :datetime
  end
end
