require_relative "../spec_helper"

describe "the mentorship process" do
  it "allows the mentee to submit a request" do
    mentee_login
    fill_in "job_Title", with: "Professor"
    select "Teacher training and education", from: "industry_Sector"
    click_button "Submit"
    click_link "View More"
      
  end

  it "can display a suitable mentor for mentees" do
    mentee_login

  end

end