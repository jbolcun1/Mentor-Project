require_relative "../spec_helper"

describe "the register page" do
  it "is accessible from the index page" do
    visit "/"
    click_button "register"
    expect(page.status_code ).to eq(200)
  end

  it "can display fields" do
    visit "/register"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Password:"
  end

end
