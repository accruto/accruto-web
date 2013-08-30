xml.instruct! :xml, :version => "1.0"
xml.Jobs do
  for job in @jobs
    xml.Job :Action => "Post" do
      xml.AdvertiserName job.company.name
      xml.SenderReference "ACC"
      xml.Classification job.subcategories.map { |sc| sc.category.name }.first
      xml.Position job.title
      xml.Description { xml.cdata!(job.description) }
      xml.Location "#{job.address.city}, #{job.address.state}, Australia"
      xml.Link generate_job_url(job)
      xml.Email ""
    end
  end
end