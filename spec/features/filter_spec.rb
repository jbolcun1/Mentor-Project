require_relative "../spec_helper"

describe "the filter functionality" do
  it "is accessible from the mentee dashboard" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    expect(page).to have_content "Please input the Job Title and Industry Sector of the mentor you want to find!"
  end

  it "can display a suitable mentor" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    fill_in "job_Title", with: "System Admin"
    select "Information technology", from: "industry_Sector"
    click_button "Submit"
    expect(page).to have_content "Mentor2 TestDudette"
  end
end
