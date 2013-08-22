class CreateReferralSites < ActiveRecord::Migration
  def change
    create_table :referral_sites do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
  end
end
