class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :unit
      t.string :street
      t.integer :postcode
      t.string :latitude
      t.string :longitude
      t.references :addressable, :polymorphic => true
      t.timestamps
    end
  end
end
