class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user
      t.string :email_frequency, default: 'Daily'

      t.timestamps
    end
  end
end
