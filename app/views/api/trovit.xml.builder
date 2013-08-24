xml.instruct! :xml, :version => "1.0"
xml.trovit do
  for job in @jobs
    xml.ad do
      xml.id { xml.cdata!(job.id.to_s) }
      xml.title { xml.cdata!(job.title) }
      xml.url { xml.cdata!(generate_job_url(job)) }
      xml.content { xml.cdata!(job.description) }
      xml.city { xml.cdata!(job.address.city) }
      xml.city_area { xml.cdata!("") }
      xml.region { xml.cdata!(job.address.state) }
      xml.postcode { xml.cdata!(job.address.postcode.nil? ? "" : job.address.postcode) }
      xml.salary { xml.cdata!("") }
      xml.working_hours { xml.cdata!("") }
      xml.company { xml.cdata!(job.company.name) }
      xml.experience { xml.cdata!("") }
      xml.requirements{ xml.cdata!("") }
      xml.contract { xml.cdata!(job.job_type) }
      xml.category { xml.cdata!(job.subcategories.map { |sc| sc.category.name }.first) }
      xml.date { xml.cdata!(job.posted_at.to_s) }
      xml.expiration_date { xml.cdata!(job.expires_at.to_s) }
      xml.studies { xml.cdata!("") }
    end
  end
end