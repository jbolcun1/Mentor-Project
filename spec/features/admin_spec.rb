require_relative "../spec_helper"

describe "the admin functionality" do
  it "makes the dashboard accessible to a logged in admin" do
    admin_login
    expect(page.status_code).to eq(200)
  end    
    
  it "displays the admin dashboard to a logged in admin" do
    admin_login
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "Welcome, Ariful Admin. You have successfully logged in as a founder."
  end
    
  it "makes the profile accessible to a logged in admin" do
    admin_login
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "Welcome, Ariful Admin. You have successfully logged in as a founder."
  end
    
  it "displays profile information to a logged in admin" do
    admin_login
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "Welcome, Ariful Admin. You have successfully logged in as a founder."
  end
  
  it "allows the admin to change their own details" do
    admin_login
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "Welcome, Ariful Admin. You have successfully logged in as a founder."
  end

  it "can find a mentor by using the filter functionality" do
    admin_login
    expect(page).to have_content "Please enter the information on the user who you want to look at!"
    fill_in "first_name", with: "Mentor1"
    fill_in "surname", with: "TestDudette"
    fill_in "job_Title", with "Professor"
    click_button "Submit"
    expect(page).to have_content "Mentor1 TestDudette"
    expect(page).to have_content "Mentor1@gmail.com"
    expect(page).to have_content "View More"
  end

  it "can find a mentee by using the filter functionality" do
    admin_login
    expect(page).to have_content "Please enter the information on the user who you want to look at!"
    fill_in "first_name", with: "Mentee1"
    fill_in "surname", with: "TestDude"
    fill_in "degree", with "Computer Science"
    click_button "Submit"
    expect(page).to have_content "Mentee1 TestDude"
    expect(page).to have_content "Mentee1@gmail.ac.uk"
    expect(page).to have_content "View More"
  end
    
  it "can change the details of a mentee" do
    mentor_login
    visit "/make-report"
    expect(page.status_code).to eq(200)
  end

  it "can change the details of a mentor" do
    mentor_login
    visit "make-report"
    expect(page).to have_content "Make a report"
    expect(page).to have_content "Please enter the details of the report you want to make"
    expect(page).to have_content "Description of what has happened:"
    expect(page).to have_button "Submit Report"
  end
    
  it "can suspend a mentee" do
    admin_login
    visit "/view-reports"
    expect(page.status_code).to eq(200)
  end

  it "can unsuspend a mentee" do
    admin_login
    visit "/view-reports"
    expect(page).to have_content "Reports Below"
    expect(page).to have_content "Name/ Email of offender"
    expect(page).to have_content "View More"
  end

  it "can suspend a mentor" do
    admin_login
    visit "/view-report-detail?id=1"
    expect(page).to have_content "The ID of the report creator 1"
    expect(page).to have_content "The person the report is against Mentor2@gmail.com"
    expect(page).to have_content "bad mentor xd"
    expect(page).to have_content "Delete report?"
    click_link "Delete report?"
    expect(page).to have_content "Reports Below"
  end     
 
  it "can unsuspend a mentor" do
    admin_login
    visit "/view-reports"
    expect(page).to have_content "Reports Below"
    expect(page).to have_content "Name/ Email of offender"
    expect(page).to have_content "View More"
  end
    
  it "can create a new admin" do
    admin_login
    visit "/view-reports"
    expect(page).to have_content "Reports Below"
    expect(page).to have_content "Name/ Email of offender"
    expect(page).to have_content "View More"
  end
   
  it "can create a new founder" do
    admin_login
    visit "/view-reports"
    expect(page).to have_content "Reports Below"
    expect(page).to have_content "Name/ Email of offender"
    expect(page).to have_content "View More"
  end    
    
end