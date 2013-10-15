class CreateBounties < ActiveRecord::Migration
  def change
    create_table :bounties do |t|
      t.string :name
      t.float :value

      t.timestamps
    end
  end
end
