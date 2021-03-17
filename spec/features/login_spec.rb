require_relative "../spec_helper"

describe "the login page" do
  it "is accessible from the index page" do
    visit "/"
    click_link "Login"
    expect(page.status_code ).to eq(200)
  end

  it "can display fields" do
    visit "/login"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Password:"
  end
  
  it "can get a mentee logged in successfully" do
      visit "/login"
      fill_in "email", with: "Mentee1@gmail.com"
      fill_in "password", with: "Password1"
      click_button "Submit"
      expect(page).to have_content "Mentee Dashboard"
  end

  it "can get a mentor logged in successfully" do
      visit "/login"
      fill_in "email", with: "Mentor1@gmail.com"
      fill_in "password", with: "Password123"
      click_button "Submit"
      expect(page).to have_content "Mentor Dashboard"
  end
    
end
