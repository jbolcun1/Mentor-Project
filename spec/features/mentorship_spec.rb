require_relative "../spec_helper"

describe "the mentorship process" do
  it "allows the mentee to send a request which the mentor will see" do
    mentee_login
    
  end

  it "can display a suitable mentor for mentees" do
    mentee_login
    fill_in "job_Title", with: "System Admin"
    select "Information technology", from: "industry_Sector"
    click_button "Submit"
    expect(page).to have_content "Mentor2 TestDudette"
  end

end