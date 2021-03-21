require_relative "../spec_helper"

describe "the register page" do
  it "is accessible from the index page" do
    visit "/"
    click_link "Login"
    click_link "Click here."
    expect(page.status_code ).to eq(200)
  end

  it "can display fields" do
    visit "/register"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Password:"
  end
    
  it "can lead registered users to the login page" do
    visit "/register"
    expect(page).to have_content "If you already have an account, click here."
  end    
    
end
