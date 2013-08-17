class AddSubscribedToRecentSearches < ActiveRecord::Migration
  def change
    add_column :recent_searches, :subscribed, :boolean, default: false
    add_column :recent_searches, :search_results, :text
  end
end
