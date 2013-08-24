xml.instruct! :xml, :version => "1.0"
xml.source do
  xml.publisher "Accruto Pty Ltd"
  xml.publisherurl "http://www.accruto.com/"
  xml.lastBuildDate Time.now
  for job in @jobs
    xml.job do
      xml.title { xml.cdata!(job.title) }
      xml.date { xml.cdata!(job.posted_at.to_s) }
      xml.referencenumber { xml.cdata!(job.id.to_s) }
      xml.url { xml.cdata!(generate_job_url(job)) }
      xml.company { xml.cdata!(job.company.name) }
      xml.city { xml.cdata!(job.address.city) }
      xml.state { xml.cdata!(job.address.state) }
      xml.country { xml.cdata!("AU") }
      xml.postalcode { xml.cdata!(job.address.postcode.nil? ? "" : job.address.postcode) }
      xml.description { xml.cdata!(job.description) }
      xml.salary { xml.cdata!("") }
      xml.education { xml.cdata!("") }
      xml.jobtype { xml.cdata!(job.job_type) }
      xml.category { xml.cdata!(job.subcategories.pluck(:name).join(",")) }
      xml.experience { xml.cdata!("") }
    end
  end
end