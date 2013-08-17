ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :user_name => ENV["SMTP_USER"],
    :password => ENV["SMTP_PASSWORD"],
    :domain => "accruto.com",
    :address => "smtp.mandrillapp.com",
    :port => 587,
    :enable_starttls_auto => true,
    :authentication => :login
}