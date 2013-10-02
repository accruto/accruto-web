class AddSummaryToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :summary, :text
  end
end
