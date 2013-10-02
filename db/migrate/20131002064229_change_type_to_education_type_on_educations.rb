class ChangeTypeToEducationTypeOnEducations < ActiveRecord::Migration
  def change
    rename_column :educations, :type, :qualification_type
  end
end
