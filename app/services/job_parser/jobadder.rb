class JobParser::Jobadder

  def initialize(doc)
    @doc = doc
  end

  def run
    puts "Start parsing JobAdder".green
    start_processing_time = Time.now
    parse_and_create_category
    parse_and_create_subcategory
    parse_and_create_job
    build_job_categories_relation
    print "All process completed in #{Time.now - start_processing_time} seconds\n".green
  end

  def parse_and_create_category
    print "Parse JobAdder Categories ... "
    start_processing_time = Time.now
    categories_source = @doc.xpath("//Category")
    jobadder_categories = categories_source.map {|category| [category.attr('id'), category.text] }.uniq

    @new_categories_temp = []
    jobadder_categories.each do |jobadder_category|
      category = JobCategory.find_by_name(jobadder_category[1])
      if category.nil?
        @new_categories_temp << { name: jobadder_category[1], external_category_ids: [{jobadder: jobadder_category[0] }] }
      end
    end
    JobCategory.create(@new_categories_temp)
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end

  def parse_and_create_subcategory
    print "Parse JobAdder Subcategories ... "
    start_processing_time = Time.now
    subcategories_source = @doc.xpath("//SubCategory")
    jobadder_subcategories = subcategories_source.map {|category| [category.attr('id'), category.text] }.uniq

    @new_categories_temp, @job_subcategories_name = [], []
    jobadder_subcategories.each do |jobadder_subcategory|
      subcategory = JobSubcategory.find_by_name(jobadder_subcategory[1])
      if subcategory.nil?
        @new_categories_temp << { name: jobadder_subcategory[1], external_subcategory_ids: [{jobadder: jobadder_subcategory[0] }] }
        @job_subcategories_name << jobadder_subcategory[1]
      else
        @job_subcategories_name << subcategory.name
      end
    end
    JobSubcategory.create(@new_categories_temp)
    collect_subcategory_ids
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end

  def collect_subcategory_ids
    @jobs_subcategories_collection = {}
    JobSubcategory.where("name IN (?) ", @job_subcategories_name).map do |subcategory|
      @jobs_subcategories_collection[subcategory.name] = { job_subcategory_id: subcategory.id, name: subcategory.name }
    end
  end

  def parse_and_create_job
    print "Parse JobAdder Jobs ... "
    start_processing_time = Time.now
    collected_jobs, @subcategories = [], {}
    @doc.xpath("//Advertiser").map do |ads_xml|
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

        if @jobs_subcategories_collection[job.xpath("SubCategory").text][:name] == job.xpath("SubCategory").text
          @subcategories[job.attr("id").to_i] = {
              external_job_id: job.attr("id").to_i,
              job_subcategory_id: @jobs_subcategories_collection[job.xpath("SubCategory").text][:job_subcategory_id]
          }
        end

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

    @inserted_jobs = Job.import collected_jobs
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end

  def build_job_categories_relation
    print "Create relation data for job and subcategories ... "
    start_processing_time = Time.now
    collected_job_categories = []
    Job.find(@inserted_jobs[:ids]).each do |job|
      if @subcategories[job.external_job_id.to_i][:external_job_id] == job.external_job_id.to_i
        job_subcategory_id = @subcategories[job.external_job_id.to_i][:job_subcategory_id]
        collected_data = {job_id: job.id, job_subcategory_id: job_subcategory_id}
        collected_job_categories << JobSubcategoriesJob.new(collected_data)
      end
    end
    JobSubcategoriesJob.import collected_job_categories
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end
end