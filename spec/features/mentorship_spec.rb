require_relative "../spec_helper"

describe "the mentorship process" do
  it "allows the mentee to submit a request" do
    mentee_login
    mentor_filter
    click_link "View More"
    fill_in "comments", with: "Hello, would you like to be my mentor?"
    click_button "Submit"
    expect(page).to have_content "Your potential Mentor's profile"
  end
end