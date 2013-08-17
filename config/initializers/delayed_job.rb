if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == 'accruto' && password == 's3cr3t'
  end
end