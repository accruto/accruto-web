class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.references :user
      t.references :job

      t.timestamps
    end
  end
end
