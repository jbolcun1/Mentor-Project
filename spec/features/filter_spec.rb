require_relative "../spec_helper"

describe "the filter functionality" do
  it "is accessible from the mentee dashboard" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    expect(page).to have_content "Please input the Job Title and Industry Sector of the mentor you want to find!"
  end

  it "can display a suitable mentor for mentees" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    fill_in "job_Title", with: "System Admin"
    select "Information technology", from: "industry_Sector"
    click_button "Submit"
    expect(page).to have_content "Mentor2 TestDudette"
  end

  it "can display more information to mentees about a potential mentor" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    fill_in "job_Title", with: "System Admin"
    select "Information technology", from: "industry_Sector"
    click_button "Submit"
    click_link "View More"
    expect(page).to have_content "Your potential Mentor's profile"
    expect(page).to have_content "The description of your mentor"
    expect(page).to have_content "Hello I am System Admin at UoS"
  end

  it "allows mentees to contact potential mentors" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    fill_in "job_Title", with: "System Admin"
    select "Information technology", from: "industry_Sector"
    click_button "Submit"
    click_link "View More"
    expect(page).to have_content "Add your introduction here!"
  end

  it "redirects mentees to their dashboard after contacting a mentor" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    fill_in "job_Title", with: "System Admin"
    select "Information technology", from: "industry_Sector"
    click_button "Submit"
    click_link "View More"
    click_button "Submit"
    expect(page).to have_content "Mentee Dashboard"
  end

  it "can display a message to mentees when no mentors are found" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    fill_in "job_Title", with: "no job"
    click_button "Submit"
    expect(page).to have_content "Sorry, no mentors found."
  end
end
