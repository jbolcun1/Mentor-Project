require_relative "../spec_helper"

describe "the about page" do
  it "is accessible" do
    visit "/about"
    expect(page.status_code).to eq(200)
  end

  it "can be accessed by a user" do
    visit "/"
    click_link "About E-Mentor"
    expect(page).to have_content "How the E-mentor scheme works:"
  end

  it "can display text" do
    visit "/about"
    expect(page).to have_content "Matching to mentors"
    expect(page).to have_content "Communicating with your mentor"
    expect(page).to have_content "You and your mentor may choose to stay"
  end
end
