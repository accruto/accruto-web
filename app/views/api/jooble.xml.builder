xml.instruct! :xml, :version => "1.0"
xml.jobs do
  for job in @jobs
    xml.job :id => job.id do
      xml.link generate_job_url(job)
      xml.name job.title
      xml.region job.address.city
      xml.salary ""
      xml.company job.company.name
      xml.company_url ""
      xml.description { xml.cdata!(job.description) }
      xml.expire job.expires_at.strftime("%m/%d/%Y")
      xml.updated job.updated_at.strftime("%m/%d/%Y")
    end
  end
end