require_relative "../spec_helper"

describe "the logout button" do
  it "is accessible by a logged in mentee" do
    mentee_login
    expect(page).to have_content "Logout"
  end

  it "can successfully log out a logged in mentee" do
    mentee_login
    click_link "Logout"
    expect(page).to have_content "Helping you to find the perfect mentor"
  end

  it "is accessible by a logged in mentor" do
    mentor_login
    expect(page).to have_content "Logout"
  end

  it "can successfully log out a logged in mentor" do
    mentor_login
    click_link "Logout"
    expect(page).to have_content "Helping you to find the perfect mentor"
  end

  it "is accessible by a logged in admin" do
    admin_login
    expect(page).to have_content "Logout"
  end

  it "can successfully log out a logged in admin" do
    admin_login
    click_link "Logout"
    expect(page).to have_content "Helping you to find the perfect mentor"
  end
end
