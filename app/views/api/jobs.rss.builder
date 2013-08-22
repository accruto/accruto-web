xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.atom :link, :href => "http://#{request.host_with_port}/api/jobs", :rel => 'self', :type =>'application/rss+xml'
    xml.title "Accruto Jobs Board"
    xml.description "Join our 600,000 customers and kick-start your new career"
    xml.link jobs_url

    for job in @jobs
      xml.item do
        xml.title job.title
        xml.description job.description
        xml.pubDate job.created_at.to_s(:rfc822)
        xml.link generate_job_url(job)
        xml.guid generate_job_url(job)
      end
    end
  end
end