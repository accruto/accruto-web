xml.instruct! :xml, :version => "1.0"
xml.jobs do
  for job in @jobs
    xml.job do
      xml.url generate_job_url(job)
      xml.title job.title
      xml.publishDate job.posted_at
      xml.expiryDate job.expires_at
      xml.company job.company.name
      xml.location job.address.street, job.address.city, job.address.state, job.address.postcode
      xml.country "au"
      xml.salary ""
      xml.contractHours job.job_type
      xml.contractType ""
      xml.description { xml.cdata!(job.description) }
    end
  end
end