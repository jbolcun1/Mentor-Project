require_relative "../spec_helper"

describe "the login page" do
  it "is accessible from the index page" do
    visit "/"
    click_link "Login"
    expect(page.status_code).to eq(200)
  end

  it "can display fields" do
    visit "/login"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Password:"
  end

  it "can lead new users to the register page" do
    visit "/login"
    expect(page).to have_content "Don't have an account?"
    expect(page).to have_content "Click here."
  end

  it "can display an error message when the credentials are wrong" do
    visit "/login"
    fill_in "email", with: "blahblah@gmail.com"
    fill_in "password", with: "ofoyfoeyfoeiyf"
    click_button "Submit"
    expect(page).to have_content "There has been an error try again"
  end

  it "can get a mentee logged in successfully" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    expect(page).to have_content "Profile"
    expect(page).to have_content "Mentee Dashboard"
    expect(page).to have_content "Logout"
  end

  it "can get a mentor logged in successfully" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    expect(page).to have_content "Profile"
    expect(page).to have_content "Mentor Dashboard"
    expect(page).to have_content "Logout"
  end

  it "can get an admin logged in successfully" do
    visit "/login"
    fill_in "email", with: "ahaque3@sheffield.ac.uk"
    fill_in "password", with: "admin"
    click_button "Submit"
    expect(page).to have_content "Profile"
    expect(page).to have_content "Dashboard"
    expect(page).to have_content "Admin Creation"
    expect(page).to have_content "Logout"
  end
end
