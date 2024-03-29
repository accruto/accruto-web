module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end

  def generate_job_url(job)
    "#{request.protocol}#{request.host_with_port}/jobs/#{job.id}"
  end

  def total_candidates
    return User.count
  end

  def controller_class
    return params[:controller].downcase
  end

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-danger"
      when :notice
        "alert-success"
      else
        flash_type.to_s
    end
  end

  def datetime_in_years(datetime)
    if datetime.present?
      return datetime.strftime("%Y")
    end
  end

  def admin_sidebar_class(action)
    return 'active' if action == "#{params[:controller]}-#{params[:action]}"
  end
end
