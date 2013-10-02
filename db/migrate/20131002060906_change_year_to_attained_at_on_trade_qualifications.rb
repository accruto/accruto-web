class ChangeYearToAttainedAtOnTradeQualifications < ActiveRecord::Migration
  def change
    rename_column :trade_qualifications, :year, :attained_at
    change_column :trade_qualifications, :attained_at, :datetime
  end
end
