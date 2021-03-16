require_relative "../spec_helper"

describe "the register page" do
    it "is accessible from the index page" do
    visit "/"
    click_button "register"
    save_page
    expect(last_response.status).to eq(200)
  end

  it "can display fields" do
    visit "/register"
    save_page
    expect(page).to include "Email:"
    expect(page).to include "Password:"
  end

  it "display an error message when fields are empty" do
    visit "/register"
    save_page
    click_button "Sign Up"
    expect(page).to have_content "Please fill out this field."
  end
end
