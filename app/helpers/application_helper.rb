module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end

  def generate_job_url(job)
    "http://accruto.com/jobs/#{job.id}"
  end
end
