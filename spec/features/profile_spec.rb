require_relative "../spec_helper"

describe "the profile page" do
  it "is accessible by logged in mentees from the dashboard" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page.status_code).to eq(200)
  end

  it "is accessible by logged in mentors from the dashboard" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page.status_code).to eq(200)
  end

  it "is accessible by logged in admins from the dashboard" do
    visit "/login"
    fill_in "email", with: "ahaque3@sheffield.ac.uk"
    fill_in "password", with: "admin"
    click_button "Submit"
    click_link "Profile"
    expect(page.status_code).to eq(200)
  end

  it "displays profile information to a logged in mentee" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page).to have_content "University:"
    expect(page).to have_content "Degree:"
    expect(page).to have_content "Telephone:"
    expect(page).to have_content "Description Of Yourself:"
  end

  it "displays profile information to a logged in mentor" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Profile"
    expect(page).to have_content "Title:"
    expect(page).to have_content "Job Title:"
    expect(page).to have_content "Industry Sector:"
    expect(page).to have_content "Available Time:"
    expect(page).to have_content "Description Of Yourself:"
  end

  it "displays profile information to a logged in admin" do
    visit "/login"
    fill_in "email", with: "ahaque3@sheffield.ac.uk"
    fill_in "password", with: "admin"
    click_button "Submit"
    click_link "Profile"
    expect(page).to have_content "Please fill in the fields you wish to change:"
    expect(page).to have_content "First Name:"
    expect(page).to have_content "Last Name:"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Description Of Yourself:"
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
