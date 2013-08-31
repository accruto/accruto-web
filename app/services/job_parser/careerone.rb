class JobParser::Careerone

  def initialize
    @subcategories_collections = {}
    @collected_jobs = []
  end

  def run
    puts "Start parsing Careerone".green
    start_processing_time = Time.now
    parse_through_subcategory
    build_job_categories_relation
    print "All process completed in #{Time.now - start_processing_time} seconds\n".green
  end

  def parse_through_subcategory
    print "Parse Careerone Categories ...\n"
    start_processing_time = Time.now

    subcategories = JobSubcategory.includes(:job_category).where("external_subcategory_id IS NOT NULL")
    subcategories.each do |subcategory|
      parse_and_create_job(subcategory) unless subcategory.job_category.nil?
    end

    print "\nImporting Jobs ... "
    @inserted_jobs = Job.import @collected_jobs
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow\
  end

  def parse_and_create_job(subcategory)
    print "Parse Careerone Jobs ... \n"
    start_processing_time = Time.now
    external_category_id = subcategory.job_category.external_category_ids[:careerone]
    external_subcategory_id = subcategory.external_subcategory_ids[:careerone]
    cat = ENV['CAREERONE_CAT_CODE']
    subcategory_id = subcategory.id

    url = "http://jsx.monster.com/query.ashx?cy=au&pp=200&tm=0d&occ=#{external_category_id}.#{external_subcategory_id}&cat=#{cat}&rev=2.0"
    remote_xml = GetRemoteXML.new(url: url)
    doc = remote_xml.send_request
    xml_jobs = doc.xpath("//Jobs/Job")
    xml_jobs.each do |job|
      puts "Processing Job ... #{job.xpath("Title").text} "
      title = job.xpath("Title").text
      description = job.xpath("Summary").text
      location = job.xpath(".//Location")
      city = location.xpath("City").text
      state = location.xpath("State").text
      company_name = job.xpath("CompanyName").text
      date_expires = job.xpath("DateExpires").text
      formatted_date_expires = DateTime.strptime(date_expires, '%m/%d/%Y')
      address = Address.find_or_create_by_city_and_state(city, state)
      posted_at = job.xpath("DateActive").text
      formatted_posted_at = DateTime.strptime(posted_at, '%m/%d/%Y')
      job_type = 'Full Time'
      company = Company.find_or_create_by_name(company_name)
      external_job_id = job.attr("ID")

      @subcategories_collections[external_job_id] = {
          external_job_id: external_job_id,
          job_subcategory_id: subcategory_id
      }

      collected_data = {
          title: title,
          address_id: address.id,
          posted_at: formatted_posted_at,
          job_type: job_type,
          company_id: company.id,
          external_job_id: external_job_id,
          description: description,
          source: "CareerOne",
          created_at: Time.now,
          updated_at: Time.now,
          expires_at: formatted_date_expires
      }

      @collected_jobs << Job.new(collected_data)
    end
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