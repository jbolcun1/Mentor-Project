require_relative "../spec_helper"

describe "the logout button" do
  it "is accessible by a logged in mentee" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    expect(page).to have_content "Logout"
  end

  it "can successfully log out a logged in mentee" do
    visit "/login"
    fill_in "email", with: "Mentee1@gmail.ac.uk"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Logout"
    expect(page).to have_content "Helping you to find the perfect mentor"
  end
  
  it "is accessible by a logged in mentor" do
      visit "/login"
      fill_in "email", with: "Mentor1@gmail.com"
      fill_in "password", with: "Password1"
      click_button "Submit"
      expect(page).to have_content "Logout"
  end

  it "can successfully log out a logged in mentor" do
    visit "/login"
    fill_in "email", with: "Mentor1@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit"
    click_link "Logout"
    expect(page).to have_content "Helping you to find the perfect mentor"
  end
    
end
