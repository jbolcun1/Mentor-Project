require_relative "../spec_helper"

describe "the login page" do
  it "is accessible from the index page" do
    visit "/"
    click_link "Login"
    expect(page.status_code).to eq(200)
  end

  it "can display text and the submit button" do
    visit "/login"
    expect(page).to have_content "Fill in credentials below to log into E-Mentor:"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Password:"
    expect(page).to have_button "Submit"
  end

  it "can lead new users to the register page" do
    visit "/login"
    expect(page).to have_content "Don't have an account?"
    expect(page).to have_button ("Click here")
  end

  it "can display an error message when the credentials are wrong" do
    visit "/login"
    fill_in "email", with: "blahblah@gmail.com"
    fill_in "password", with: "ofoyfoeyfoeiyf"
    click_button "Submit"
    expect(page).to have_content "There has been an error try again"
  end

  it "can get a mentee logged in successfully" do
    mentee_login
    expect(page).to have_content "Profile"
    expect(page).to have_content "Mentee Dashboard"
    expect(page).to have_content "Make A Report"
    expect(page).to have_content "Logout"
    expect(page).to have_content "Welcome, Mentee1 TestDude. You have sucessfully logged in as a mentee."
  end

  it "can get a mentor logged in successfully" do
    mentor_login
    expect(page).to have_content "Profile"
    expect(page).to have_content "Mentor Dashboard"
    expect(page).to have_content "Make A Report"
    expect(page).to have_content "Logout"
    expect(page).to have_content "Welcome, Mentor1 TestDudette. You have sucessfully logged in as a mentor."
  end

  it "can get an admin logged in successfully" do
    admin_login
    expect(page).to have_content "Profile"
    expect(page).to have_content "Dashboard"
    expect(page).to have_content "Admin Creation"
    expect(page).to have_content "View Reports"
    expect(page).to have_content "Logout"
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "Welcome, Ariful Admin. You have successfully logged in as a founder."
  end
end
