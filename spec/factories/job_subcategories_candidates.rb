# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_subcategories_candidate, :class => 'JobSubcategoriesCandidates' do
    candidate nil
    job_category nil
  end
end
