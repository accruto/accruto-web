# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recent_search do
    job_title "Ruby On Rails"
    address "Sydney"
    days "14"
    sort "relevance"
    category ""
    user_id 100
    search_at "2013-08-15 06:49:53"
    source {}
  end
end