# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_category do
    name "Editorial & Writing"
    external_category_id 8888
    after(:create) do |job_category|
    	job_category.subcategories << create(:job_subcategory, name: "Translation & Interpretation")
    	job_category.subcategories << create(:job_subcategory, name: "Digital Content Development")
    end
  end
end
