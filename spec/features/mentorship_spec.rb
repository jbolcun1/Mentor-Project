require_relative "../spec_helper"

describe "the mentorship process" do
  it "allows the mentee to submit a request" do
    mentee_login
    mentor_filter
    send_invitation
    expect(page).to have_content "Your potential Mentor's profile"
  end
    
  it "allows the mentor to see the request" do
    mentor_login
    expect(page).to have_content "You have a potential mentorship"
    expect(page).to have_content "Mentee1 TestDude"
  end    
    
  it "allows the mentor to reject the request" do
    mentor_login
    click_link "View More"
    expect(page).to have_content "Choose what you want to do with the invite and click submit to send your decision:"
    choose("rejectDecision")
    click_button "Submit"
    expect(page).to have_content "Currently you have no requests from any mentees."
  end        
    
  it "allows the mentor to accept the request" do
    reset_mentee
    mentee_login
    mentor_filter
    send_invitation
    click_link "Logout"
    mentor_login
    save_page
    click_link "View More"
    choose("acceptDecision")
    click_button "Submit"
    expect(page).to have_content "Mentee1@gmail.ac.uk"
  end  
    
  it "allows the mentee to see the mentor's contact details after the request has been accepted" do
    mentee_login
    expect(page).to have_content "You have been matched. Details to talk to them are below!"
    expect(page).to have_content "Mentor1 TestDudette"
    expect(page).to have_content "Mentor1@gmail.com"
    reset_mentee
    reset_mentor
  end
end