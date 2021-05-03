require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe User do
  include Rack::Test::Methods
  let(:user){ User.new }
  
  describe "#name" do
    it "returns the User's name and surname" do
      user = described_class.new(first_name: "John", surname: "Smith")
      expect(user.name).to eq("John Smith")
    end
  end

  describe "#load" do
    it "loads the user's information into a new instance of the User object" do
      params = { "first_name" => "Alan", "surname" => "Smith", "email" => "AlanS@gmail.com", "password" => "Password1",
                 "confirmpassword" => "Password1", "privilege" => "Mentee" }
      user.load(params)
      expect(user.first_name).to eq("Alan")
      expect(user.surname).to eq("Smith")
      expect(user.email).to eq("AlanS@gmail.com")
      expect(user.password).to eq("Password1")
      expect(user.privilege).to eq(2)
    end
  end
  
  describe "#load_profile" do
    it "used to load the updated account information of the user" do
      params = { "first_name" => "Alan", "surname" => "Smith", "email" => "AlanS@gmail.com", "password" => "Password1",
                 "confirmpassword" => "Password1", "privilege" => "Mentee" }
      updatedInfo = { "first_name" => "Gordon", "surname" => "Ramsay", "email" => "GR11@gmail.com"}
      user.load(params)
      user.load_profile(updatedInfo)
      expect(user.first_name).to eq("Gordon")
      expect(user.surname).to eq("Ramsay")
      expect(user.email).to eq("GR11@gmail.com")
      expect(user.password).to eq("Password1")
      expect(user.privilege).to eq(2)
    end
  end

  describe "#validPass" do
    it "returns true if password matches with confirm password" do
      params = { "password" => "Password1", "confirmpassword" => "Password1" }
      expect(user.valid_pass(params)).to eq(true)
    end
  end
 
  describe "#get_descriptions" do
    context "When a description object is given for a particular user" do
      it "returns the description text stored in the description database" do
        description = Description.new(description: "I am a Computer Science Student.")
        description.save_changes
        user.description = description.id
        user.save_changes
        expect(user.get_descriptions).to eq("I am a Computer Science Student.")
        user.delete
        description.delete
      end
    end
  end
  
  describe "#get_privileges" do
    it "will return the privilege of the user's account" do
      user.privilege = 2
      expect(user.get_privileges).to eq("Mentee")
    end
  end
  
  describe "#get_titles" do
    it "will return the title of the user" do
      user.title = 1
      expect(user.get_titles).to eq("Mr")
    end
  end
  
  describe "#get_industry_sectors" do
    it "will return the industry sector assigned to the user's account" do
      user.industry_sector = 9
      expect(user.get_industry_sectors).to eq("Hospitality and events management")
    end
  end
  
  describe "#valid_pass_profile" do
    context "When on the page for changing account information" do
      it "will check if the newly inputed password and confirmpassword match or not" do
        params = {"newpassword" => "randomPassword123", "newconfirmpassword" => "randomPassword123"}
        expect(user.valid_pass_profile(params)).to eq(true)
      end
    end
  end
end

