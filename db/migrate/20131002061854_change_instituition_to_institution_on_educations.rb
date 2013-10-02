class ChangeInstituitionToInstitutionOnEducations < ActiveRecord::Migration
  def change
    rename_column :educations, :instituition, :institution
  end
end

