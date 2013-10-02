class CreateTradeQualifications < ActiveRecord::Migration
  def change
    create_table :trade_qualifications do |t|
      t.string :name
      t.datetime :year

      t.timestamps
    end
  end
end
