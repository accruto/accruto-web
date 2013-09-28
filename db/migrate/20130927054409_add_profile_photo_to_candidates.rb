class AddProfilePhotoToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :profile_photo, :string
  end
end
