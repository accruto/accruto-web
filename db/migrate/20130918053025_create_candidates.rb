class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :status
      t.string :job_title
      t.integer :address_id
      t.string :visa

      t.timestamps
    end
  end
end
