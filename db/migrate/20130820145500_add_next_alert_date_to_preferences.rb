class AddNextAlertDateToPreferences < ActiveRecord::Migration

  def change
    add_column :preferences, :next_alert_date, :date
  end
end
