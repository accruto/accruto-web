class AddIndexToJobs < ActiveRecord::Migration
  def change
  	add_index :jobs, :title
  	add_index :jobs, :description
  	add_index :jobs, :company_id
  	add_index :jobs, :address_id
  end
end
