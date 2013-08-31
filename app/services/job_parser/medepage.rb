class JobParser::Medepage

  def initialize
    url = "http://premiumjobs.orangestateofmind.com/xmlfile/premium-jobs.xml"
    remote_xml = GetRemoteXML.new(url: url)
    @doc = remote_xml.send_request
    @collected_jobs = []
    @subcategories_collections = {}
  end

  def run
    puts "Start parsing Medepage".green
    start_processing_time = Time.now
    parse_and_create_job
    build_job_categories_relation
    print "All process completed in #{Time.now - start_processing_time} seconds\n".green
  end

  def parse_and_create_job
    print "Parse Medepage Job ... \n"
    start_processing_time = Time.now
    category = JobCategory.find_or_create_by_name('Health, Medical & Pharmaceutical')
    xml_jobs = @doc.xpath("//Jobs/Job")
    xml_jobs.each do |job|
      puts "Processing Job ... #{job.xpath("Position").text} "
      title = job.xpath("Position").text
      description = job.xpath("Description").text
      location = job.xpath("Location").text
      address = Address.find_or_create_by_city(location)
      job_type = 'Full Time'
      company_name = job.xpath("AdvertiserName").text
      company = Company.find_or_create_by_name(company_name)
      external_job_id = job.xpath("SenderReference").text
      external_apply_url = job.xpath("ApplicationURL").text
      external_subcategory = job.xpath("Classification").text

      subcategory = JobSubcategory.find_or_create_by_name_and_job_category_id(external_subcategory, category.id)
      external_subcategory_ids_temp = subcategory.external_subcategory_ids
      external_subcategory_ids_temp[:medepage] = external_job_id
      subcategory.update_attribute(:external_subcategory_ids, external_subcategory_ids_temp)

      @subcategories_collections[external_job_id] = {
          external_job_id: external_job_id,
          job_subcategory_id: subcategory.id
      }

      collected_data = {
          title: title,
          address_id: address.id,
          posted_at: Time.now,
          job_type: job_type,
          company_id: company.id,
          external_job_id: external_job_id,
          description: description,
          source: "Medepage",
          expires_at: 30.days.from_now,
          external_apply_url: external_apply_url
      }

      @collected_jobs << Job.new(collected_data)
    end

    print "\nImporting Jobs ... "
    @inserted_jobs = Job.import @collected_jobs
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end

  def build_job_categories_relation
    print "Create relation data for job and subcategories ... "
    start_processing_time = Time.now
    collected_job_categories = []
    Job.find(@inserted_jobs[:ids]).each do |job|
      if @subcategories_collections[job.external_job_id][:external_job_id].to_i == job.external_job_id.to_i
        job_subcategory_id = @subcategories_collections[job.external_job_id][:job_subcategory_id].to_i
        collected_data = {job_id: job.id, job_subcategory_id: job_subcategory_id}
        collected_job_categories << JobSubcategoriesJob.new(collected_data)
      end
    end
    JobSubcategoriesJob.import collected_job_categories
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end
end