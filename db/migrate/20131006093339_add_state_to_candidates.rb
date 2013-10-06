class AddStateToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :state, :string, default: 'unpublished'
  end
end
