require_relative "../spec_helper"

describe "the register page" do
  it "is accessible from the index page" do
    visit "/"
    click_link "Login"
    click_link "Click here"
    expect(page.status_code).to eq(200)
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

  it "prints response to different password and confirm password" do
    visit "/register"
    fill_in "first_name", with: "Text"
    fill_in "surname", with: "Text"
    fill_in "email", with: "Text.ac.uk"
    fill_in "password", with: "ABCDE"
    fill_in "confirmpassword", with: "AECDB"
    choose("mentee")
    click_button "Sign Up"
    expect(page).to have_content "The two password entries must be correct."
  end

  it "will direct to the mentee description page after registering details." do
    visit "/register"
    fill_in "first_name", with: "John"
    fill_in "surname", with: "Calvert"
    fill_in "email", with: "Mentee@gmail.ac.uk"
    fill_in "password", with: "Password1"
    fill_in "confirmpassword", with: "Password1"
    choose("mentee")
    click_button "Sign Up"
    expect(page).to have_content "Hello prospective Mentee, John Calvert. Please input the details below!"
  end

  it "will direct to the mentor description page after registering details." do
    visit "/register"
    fill_in "first_name", with: "John"
    fill_in "surname", with: "Calvert"
    fill_in "email", with: "Mentor@gmail.com"
    fill_in "password", with: "Password1"
    fill_in "confirmpassword", with: "Password1"
    choose("mentor")
    click_button "Sign Up"
    expect(page).to have_content "Hello prospective mentor, John Calvert. Please input the details below!"
  end
end
