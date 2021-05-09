# Configure coverage logging
require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end
SimpleCov.coverage_dir "coverage"

# Ensure we use the test database
ENV["APP_ENV"] = "test"

# load the app
require_relative "../app"

# load the test db
init_db

# Configure Capybara
require "capybara/rspec"
Capybara.app = Sinatra::Application
Capybara.configure do |config|
  config.save_path = ("capybara/")
end

# Configure RSpec
def app
  Sinatra::Application
end
RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

# Mentee login method
def mentee_login 
  visit "/login"
  fill_in "email", with: "Mentee1@gmail.ac.uk"
  fill_in "password", with: "Password1"
  click_button "Submit"
end

# Mentor login method
def mentor_login
  visit "/login"
  fill_in "email", with: "Mentor1@gmail.com"
  fill_in "password", with: "Password1"
  click_button "Submit"
end

# Admin login method
def admin_login
  visit "/login"
  fill_in "email", with: "ahaque3@sheffield.ac.uk"
  fill_in "password", with: "admin"
  click_button "Submit"    
end

# Filter method
def mentor_filter
  fill_in "job_Title", with: "Professor"
  select "Teacher training and education", from: "industry_Sector"
  click_button "Submit"    
end    

def reset_mentee 
  @mentees = Mentee.where(Privilege: 1)
  @mentees.each do |mentee|
    mentee.last_send = "0"
    mentee.has_mentor = 0
    mentee.save_changes
  end
end