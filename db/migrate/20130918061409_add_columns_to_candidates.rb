class AddColumnsToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :minimum_annual_salary, :integer
  end
end
