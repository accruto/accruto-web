class JobParser::Medepage

  def initialize
    url = "http://premiumjobs.orangestateofmind.com/xmlfile/premium-jobs.xml"
    remote_xml = GetRemoteXML.new(url: url)
    @doc = remote_xml.send_request
    @collected_jobs = []
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
      external_job_id = job.attr("SenderReference")

      collected_data = {
          title: title,
          address_id: address.id,
          posted_at: Time.now,
          job_type: job_type,
          company_id: company.id,
          external_job_id: external_job_id,
          description: description,
          source: "Medepage",
          created_at: Time.now,
          updated_at: Time.now,
          expires_at: 30.days.from_now
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
    category = JobCategory.find_or_create_by_name('Health, Medical & Pharmaceutical')
    subcategory = JobSubcategory.find_or_create_by_name_and_job_category_id('Classification', category.id)
    collected_job_categories = []
    Job.find(@inserted_jobs[:ids]).each do |job|
      collected_data = {job_id: job.id, job_subcategory_id: subcategory.id}
      collected_job_categories << JobSubcategoriesJob.new(collected_data)
    end
    JobSubcategoriesJob.import collected_job_categories
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
  end
end