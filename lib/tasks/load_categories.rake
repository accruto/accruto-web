namespace :load_categories do
	desc "Seeds database with careerone categories"
	task :career_one => :environment do
		categories = [
			{ name: "Accounting", external_category_id: 1 },
			{ name: "Administration & Secretarial", external_category_id: 2 },
			{ name: "Advertising, Media, Arts & Entertainment", external_category_id: 11454 },
			{ name: "Agriculture, Nature & Animal", external_category_id: 15425 },
			{ name: "Banking & Finance", external_category_id: 558 },
			{ name: "Biotech, R&D, Science", external_category_id: 559 },
			{ name: "Construction, Architecture & Interior Design", external_category_id: 544 },
			{ name: "Customer Service & Call Centre", external_category_id: 545 },
			{ name: "Editorial & Writing", external_category_id: 5623 },
			{ name: "Education, Childcare & Training", external_category_id: 3 },
			{ name: "Engineering", external_category_id: 4 },
			{ name: "Executive & Strategic Management", external_category_id: 3561 },
			{ name: "Government, Defence & Emergency", external_category_id: 15431 },
			{ name: "Health, Medical & Pharmaceutical", external_category_id: 3975 },
			{ name: "Hospitality, Travel & Tourism", external_category_id: 13 },
			{ name: "HR & Recruitment", external_category_id: 5 },
			{ name: "Insurance & Superannuation", external_category_id: 15426 },
			{ name: "IT", external_category_id: 660 },
			{ name: "Legal", external_category_id: 7 },
			{ name: "Logistics, Supply & Transport", external_category_id: 5625 },
			{ name: "Manufacturing & Industrial", external_category_id: 47 },
			{ name: "Marketing", external_category_id: 9007 },
			{ name: "Mining, Oil & Gas", external_category_id: 15430 },
			{ name: "Other", external_category_id: 11 },
			{ name: "Program & Project Management", external_category_id: 9008 },
			{ name: "Property & Real Estate", external_category_id: 15427 },
			{ name: "Quality Assurance & Safety", external_category_id: 11455 },
			{ name: "Retail", external_category_id: 15428 },
			{ name: "Sales", external_category_id: 10 },
			{ name: "Security & Protective Services", external_category_id: 555 },
			{ name: "Trades & Services", external_category_id: 553 },
			{ name: "Voluntary, Charity & Social Work", external_category_id: 15429 }
		]
		JobCategory.delete_all
		categories.each do |c|
			category_obj = OpenStruct.new(c)
			category = JobCategory.find_or_initialize_by_external_category_id(category_obj.external_category_id)
			category.name = category_obj.name
			category.external_category_id = category_obj.external_category_id
			category.save
		end
	end
end