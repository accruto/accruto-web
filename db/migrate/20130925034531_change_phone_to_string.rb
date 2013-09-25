class ChangePhoneToString < ActiveRecord::Migration
  def up
    change_column :candidates, :phone, :string
  end

  def down
    change_column :candidates, :phone, :integer
  end
end
