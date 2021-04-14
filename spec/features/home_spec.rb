require_relative "../spec_helper"

describe "the home page" do
  it "is accessible by a user" do
    visit "/"
    expect(page.status_code).to eq(200)
  end

  it "can display text" do
    visit "/"
    expect(page).to have_content "Quickly. Effiently."
    expect(page).to have_content "Bob Proctor"
  end

  it "can display all the buttons" do
    visit "/"
    expect(page).to have_content "Home"
    expect(page).to have_content "About E-Mentor"
    expect(page).to have_content "Login"
  end

  it "can display the copyright" do
    visit "/"
    expect(page).to have_content "&copy COM1001 Team 2"
  end

  it "can display the logo" do
    visit "/"
    expect(page.find('#logo')['src']).to match 'images/E-mentor.PNG'
  end
end
