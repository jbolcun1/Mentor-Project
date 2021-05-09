require_relative "../spec_helper"

describe "the report functionality" do
  it "is displays a message to admins when there are no reports" do
    admin_login
    visit "/view-reports"
    expect(page).to have_content "Sorry, no reports found."
  end    
    
  it "is accessible by logged in mentees" do
    mentee_login
    visit "/make-report"
    expect(page.status_code).to eq(200)
  end

  it "can display relevant content to a logged in mentee" do
    mentee_login
    visit "make-report"
    expect(page).to have_content "Make a report"
    expect(page).to have_content "Please enter the details of the report you want to make"
    expect(page).to have_content "Description of what has happened:"
    expect(page).to have_button "Submit Report"
  end

  it "allows the mentee to submit a report" do
    mentee_login
    visit "/make-report"
    fill_in "identifier", with: "Mentor2@gmail.com"
    fill_in "description", with: "bad mentor xd"
    click_button "Submit"
    expect(page).to have_content "Mentee Dashboard"
  end
    
  it "is accessible by logged in mentors" do
    mentor_login
    visit "/make-report"
    expect(page.status_code).to eq(200)
  end

  it "can display relevant content to a logged in mentor" do
    mentor_login
    visit "make-report"
    expect(page).to have_content "Make a report"
    expect(page).to have_content "Please enter the details of the report you want to make"
    expect(page).to have_content "Description of what has happened:"
    expect(page).to have_button "Submit Report"
  end

  it "allows the mentor to submit a report" do
    mentor_login
    visit "/make-report"
    fill_in "identifier", with: "Mentor1@gmail.com"
    fill_in "description", with: "bad mentor lol"
    click_button "Submit"
    expect(page).to have_content "Mentor Dashboard"
  end 
    
  it "is accessible by logged in admins" do
    admin_login
    visit "/view-reports"
    expect(page.status_code).to eq(200)
  end

  it "can display relevant content to a logged in admin" do
    admin_login
    visit "/view-reports"
    expect(page).to have_content "Reports Below"
    expect(page).to have_content "Name/ Email of offender"
    expect(page).to have_content "View More"
  end

  it "allows the admin to view and delete a report" do
    admin_login
    visit "/view-report-detail?id=1"
    expect(page).to have_content "The ID of the report creator 1"
    expect(page).to have_content "The person the report is against Mentor2@gmail.com"
    expect(page).to have_content "bad mentor xd"
    expect(page).to have_content "Delete report?"
    click_link "Delete report?"
    expect(page).to have_content "Reports Below"
  end     
    
end