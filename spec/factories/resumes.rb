# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resume do
    association :candidate
    courses "MyText"
    awards "MyText"
    skills "MyText"
    objective "MyText"
    summary "MyText"
    other "MyString"
    citizenship "MyString"
    affiliations "MyText"
    professional "MyText"
    interests "MyText"
    referees "MyText"
    updated_at_linkme "2013-09-26 16:05:17"
  end
end
