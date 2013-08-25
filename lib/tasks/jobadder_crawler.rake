require 'net/https'

namespace 'accruto:jobadder' do
  desc "Load and parse jobadder feed"
  task :load => :environment do
    url = URI.parse("https://feeds.jobadder.com/jobs/all")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url.path)
    request.basic_auth('linkme', 'pe5redef')
    response = http.start { |http| http.request(request) }
    doc = Nokogiri::XML(response.body)

    ## parse categories
    puts "Parse JobAdder Categories"
    categories_source = doc.xpath("//Category")
    jobadder_categories = categories_source.map {|category| [category.attr('id'), category.text] }.uniq

    new_categories_temp = []
    jobadder_categories.each do |jobadder_category|
      category = JobCategory.find_by_name(jobadder_category[1])
      if category.nil?
        new_categories_temp << { name: jobadder_category[1], external_category_ids: [{jobadder: jobadder_category[0] }] }
      end
    end
    JobCategory.create(new_categories_temp)

    ## parse subcategories
    puts "Parse JobAdder Subcategories"
    subcategories_source = doc.xpath("//SubCategory")
    jobadder_subcategories = subcategories_source.map {|category| [category.attr('id'), category.text] }.uniq

    new_categories_temp = []
    jobadder_subcategories.each do |jobadder_subcategory|
      category = JobSubcategory.find_by_name(jobadder_subcategory[1])
      if category.nil?
        new_categories_temp << { name: jobadder_subcategory[1], external_subcategory_ids: [{jobadder: jobadder_subcategory[0] }] }
      end
    end
    JobSubcategory.create(new_categories_temp)

    ## parse job
    puts "Parse JobAdder Jobs"
    collected_jobs = []
    doc.xpath("//Advertiser").map do |ads_xml|
      company_name = ads_xml.xpath("Name").text
      company = Company.find_or_create_by_name(company_name)
      ads_xml.xpath("//Job").map do |job|
        title = job.xpath("Title").text
        location = job.xpath("Location").text
        address = Address.find_by_city_and_street(location,"") || Address.where("city ILIKE ? AND street = ''", "%#{location}%").first
        address = Address.find_or_create_by_city(location) if address.nil?
        posted_at = job.attr("datePosted")
        job_type = job.xpath("JobType").text
        company_id = company.id
        external_job_id = job.attr("id")
        description = job.xpath("Description").text

        collected_data = {
            title: title,
            address_id: address.id,
            posted_at: posted_at,
            job_type: job_type,
            company_id: company_id,
            external_job_id: external_job_id,
            description: description,
            source: "JobAdder",
            created_at: Time.now,
            updated_at: Time.now
        }

        collected_jobs << Job.new(collected_data)
      end
    end

    puts "Import JobAdder Jobs ..."
    Job.import collected_jobs
    puts "Done"
  end
end