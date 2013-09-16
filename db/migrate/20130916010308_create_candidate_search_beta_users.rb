class CreateCandidateSearchBetaUsers < ActiveRecord::Migration
  def change
    create_table :candidate_search_beta_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
