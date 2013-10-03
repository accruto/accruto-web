class ChangesToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :qualification_major, :string
    add_column :educations, :start_at, :datetime
  end
end
