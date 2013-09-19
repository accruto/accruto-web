require 'simplecov'
SimpleCov.start 'rails'

require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
  	config.include FactoryGirl::Syntax::Methods
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
    #config.filter_run :focus => true

    ## https://code.google.com/p/chromedriver/downloads/list
    ## https://code.google.com/p/selenium/wiki/ChromeDriver

    # Capybara.register_driver :selenium_chrome do |app|
    #   Capybara::Selenium::Driver.new(app, :browser => :chrome)
    # end
    # Capybara.current_driver = :selenium_chrome
    # Capybara.javascript_driver = :selenium_chrome
    # Capybara.run_server = true
    # Capybara.server_port = 7000
    # Capybara.app_host = "http://localhost:#{Capybara.server_port}"

    Capybara.javascript_driver = :webkit

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end

end

Spork.each_run do
  FactoryGirl.reload
end