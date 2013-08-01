# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_category do
    name "Legal"
    external_category_id 8888
    after(:create) do |job_category|
    	job_category.subcategories << create(:job_subcategory)
    	job_category.subcategories << create(:job_subcategory, name: "Mining")
    end
  end
end
