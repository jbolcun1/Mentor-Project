require_relative "../spec_helper"

describe "the profile page" do
  it "is accessible by logged in mentees from the dashboard" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page.status_code ).to eq(200)
  end
    
  it "is accessible by logged in mentors from the dashboard" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page.status_code ).to eq(200)
  end
    
  it "displays information about the page to a logged in mentee" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page).to have_content "Please fill in the fields you wish to change:"
  end
    
  it "displays information about the page to a logged in mentor" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page).to have_content "Please fill in the fields you wish to change:"
  end
    
  it "displays the dashboard if the old password is not entered" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    click_button "Change Details"
    expect(page).to have_content "Dashboard"
  end
    
  it "displays an error message if the new passwords don't match" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    fill_in "password", with: "Password1"
    fill_in "newpassword", with: "blah"
    fill_in "newconfirmpassword", with: "error"
    click_button "Change Details"
    expect(page).to have_content "The two password entries must be correct."
  end

end