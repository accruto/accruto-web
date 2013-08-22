module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def generate_job_url(job)
    if job.source.downcase == 'careerone'
      "http://jobview.careerone.com.au/GetJob.aspx?JobID=#{job.external_job_id}&WT.mc_n=AFC_linkme"
    else
      job_path(job)
    end
  end
end
