class AddCandidateIdToTradeQualifications < ActiveRecord::Migration
  def change
    add_column :trade_qualifications, :candidate_id, :integer
  end
end
