class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :postcode
      t.string :state
      t.float :latitude
      t.float :longitude
      t.references :addressable, :polymorphic => true
      t.timestamps
    end
  end
end
