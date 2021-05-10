require_relative "../spec_helper"

describe "the filter functionality" do
  it "is accessible from the mentee dashboard" do
    mentee_login
    expect(page).to have_content "Please input the Job Title and Industry Sector of the mentor you want to find!"
    expect(page).to have_content "Job Title"
    expect(page).to have_content "Industry Sector"
    expect(page).to have_button "Submit"
  end

  it "can display a suitable mentor for mentees" do
    mentee_login
    mentor_filter
    expect(page).to have_content "Mentor1 TestDudette"
  end

  it "can display more information to mentees about a potential mentor" do
    mentee_login
    mentor_filter
    click_link "View More"
    expect(page).to have_content "The mentor you have selected is: Mentor1 TestDudette"
    expect(page).to have_content "The mentor's available time is: Friday Afternoons"
    expect(page).to have_content "The description of your mentor:"
    expect(page).to have_content "A changed description."
  end

  it "displays relevant information about contacting mentors to mentees" do
    mentee_login
    mentor_filter
    click_link "View More"
    expect(page).to have_content "Add your introduction here!"
    expect(page).to have_button "Submit"
  end

  it "redirects mentees to their dashboard after contacting a mentor" do
    mentee_login
    mentor_filter
    click_link "View More"
    click_button "Submit"
    expect(page).to have_content "Mentee Dashboard"
  end

  it "can display a message to mentees when no mentors are found" do
    mentee_login
    fill_in "job_Title", with: "no job"
    click_button "Submit"
    expect(page).to have_content "Sorry, no mentors found."
  end
    
  it "allows admins to search for a mentor" do
    admin_login
    expect(page).to have_content "Please enter the information on the user who you want to look at!"
    fill_in "first_name", with: "Mentor1"
    fill_in "surname", with: "TestDudette"
    fill_in "job_Title", with: "Professor"
    click_button "Submit"
    expect(page).to have_content "Mentor1 TestDudette"
    expect(page).to have_content "Mentor1@gmail.com"
    expect(page).to have_content "View More"
  end

  it "allows admins to search for a mentee" do
    admin_login
    expect(page).to have_content "Please enter the information on the user who you want to look at!"
    fill_in "first_name", with: "Mentee1"
    fill_in "surname", with: "TestDude"
    fill_in "degree", with: "Computer Science"
    click_button "Submit"
    expect(page).to have_content "Mentee1 TestDude"
    expect(page).to have_content "Mentee1@gmail.ac.uk"
    expect(page).to have_content "View More"
  end    
    
end
