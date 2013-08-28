namespace 'accruto:feed:categories' do
  desc "Update categories and subcategories"
  task :update => :environment do
    categories = JobCategory.includes(:subcategories).where("job_subcategories.external_subcategory_id IS NOT NULL")
    categories.each do |category|
      external_ids = category.external_category_ids
      external_id = category.external_category_id
      if external_ids.has_key?(:careerone)
        update_category_ids(category, external_id) if external_ids[:careerone] != external_id
      else
        update_category_ids(category, external_id)
      end

      category.subcategories.each do |subcategory|
        subexternal_ids = subcategory.external_subcategory_ids
        subexternal_id = subcategory.external_subcategory_id

        if subexternal_ids.has_key?(:careerone)
          update_subcategory_ids(subcategory, subexternal_id) if subexternal_ids[:careerone] != subexternal_id
        else
          update_subcategory_ids(subcategory, subexternal_id)
        end
      end
    end
  end

  def update_category_ids(category, external_id)
    category.external_category_ids[:careerone] = external_id
    category.save
  end

  def update_subcategory_ids(subcategory, subexternal_id)
    subcategory.external_subcategory_ids[:careerone] = subexternal_id
    subcategory.save
  end
end