require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe User do
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
      expect(user.privilege).to eq("Mentee")
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
      expect(user.privilege).to eq("Mentee")
    end
  end

  describe "#validPass" do
    it "returns true if password matches with confirm password" do
      params = { "password" => "Password1", "confirmpassword" => "Password1" }
      expect(user.valid_pass(params)).to eq(true)
    end
  end
end

#  Cannot test get_description as the user_Id is nil and i cannot assign a number to a restricted primary key  
#  describe "#get_descriptions"do
#    context "When a description object is given for a particular user" do
#      it "returns the description text stored in the description database" do
#        user = described_class.new
#        description = Description.new(description: "I am a Computer Science Student.")
#        user.description = description.user_Id
#        expect(description).to respond_to(:load_profile)
#        #expect(user.get_descriptions).to eq("I am a Computer Science Student.")
#      end
#    end
#  end

