require_relative "../spec_helper"

describe "the admin functionality" do
  it "makes the dashboard accessible to a logged in admin" do
    admin_login
    expect(page.status_code).to eq(200)
  end    
    
  it "displays the admin dashboard to a logged in admin" do
    admin_login
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "Welcome, Ariful Admin. You have successfully logged in as a founder."
  end
    
  it "makes the profile accessible to a logged in admin" do
    admin_login
    visit "/profile"
    expect(page.status_code).to eq(200)
  end
    
  it "displays profile information to a logged in admin" do
    admin_login
    visit "/profile"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Admin"
    expect(page).to have_content "Description Of Yourself:"
    expect(page).to have_content "I am founder admin"
  end
  
  it "allows the admin to change their own details" do
    admin_login
    visit "/profile"
    expect(page).to have_content "Please fill in the fields you wish to change:"
    fill_in "description", with: "A changed description."
    click_button "Change Details"
    visit "/profile"
    expect(page).to have_content "A changed description."
  end
    
  it "can change the details of a mentee" do
    admin_login
    filter_mentee_admin
    expect(page).to have_content "The user you have selected is: Mentee1 TestDude"
    click_link "Change Details"
    fill_in "description", with: "A changed description."
    click_button "Change Details"
    filter_mentee_admin
    expect(page).to have_content "A changed description."
  end

  it "can change the details of a mentor" do
    admin_login
    filter_mentor_admin
    expect(page).to have_content "The user you have selected is: Mentor1 TestDudette"
    click_link "Change Details"
    fill_in "description", with: "A changed description."
    click_button "Change Details"
    filter_mentor_admin
    expect(page).to have_content "A changed description."
  end
    
  it "can suspend a mentee" do
    admin_login
    filter_mentee_admin
    click_link "Suspension"
    choose "suspend"
    click_button "Suspend / Unsuspend"
    visit "/suspension?id=1"
    expect(page).to have_content "They are suspended"
  end
  
  it "can display a message to a suspended mentee" do
    mentee_login
    expect(page).to have_content "You have been suspended"
  end      
      
  it "can unsuspend a mentee" do
    admin_login
    filter_mentee_admin
    click_link "Suspension"
    choose "suspend"
    click_button "Suspend / Unsuspend"
    visit "suspension?id=1"
    expect(page).to have_content "They are not suspended"
  end

  it "can suspend a mentor" do
    admin_login
    filter_mentor_admin
    click_link "Suspension"
    choose "suspend"
    click_button "Suspend / Unsuspend"
    visit "/suspension?id=3"
    expect(page).to have_content "They are suspended"
  end     

  it "can display a message to a suspended mentor" do
    mentor_login
    expect(page).to have_content "You have been suspended"
  end        
    
  it "can unsuspend a mentor" do
    admin_login
    filter_mentor_admin
    click_link "Suspension"
    choose "suspend"
    click_button "Suspend / Unsuspend"
    visit "suspension?id=3"
    expect(page).to have_content "They are not suspended"
  end
    
  it "can create a new admin" do
    admin_login
    visit "/admin-creation"
    fill_in "first_name", with: "NewAdmin"
    fill_in "surname", with: "Admin"
    fill_in "email", with: "newadmin@gmail.com"
    fill_in "password", with: "Password1"
    fill_in "confirmpassword", with: "Password1"
    choose "admin"
    click_button "Sign Up"
    expect(page).to have_content "The account has been made!"
  end
    
  it "allows the new admin to log in and view their page" do
    visit "/login"
    fill_in "email", with: "newadmin@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit" 
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "View Reports"
    expect(page).not_to have_content "Admin Creation"
  end    
    
  it "can create a new founder" do
    admin_login
    visit "/admin-creation"
    fill_in "first_name", with: "NewFounder"
    fill_in "surname", with: "Founder"
    fill_in "email", with: "newfounder@gmail.com"
    fill_in "password", with: "Password1"
    fill_in "confirmpassword", with: "Password1"
    choose "founder"
    click_button "Sign Up"
    expect(page).to have_content "The account has been made!"
  end   
    
  it "allows the new founder to log in and view their page" do
    visit "/login"
    fill_in "email", with: "newfounder@gmail.com"
    fill_in "password", with: "Password1"
    click_button "Submit" 
    expect(page).to have_content "Your Admin Page"
    expect(page).to have_content "View Reports"
    expect(page).to have_content "Admin Creation"
  end    
    
end