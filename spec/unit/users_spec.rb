require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe User do
  describe "#name" do
    it "returns the User's name and surname" do
      user = described_class.new(first_name: "John", surname: "Smith")
      expect(user.name).to eq("John Smith")
    end
  end
  
  describe "#load" do
    it "loads the user's information into a new instance of the User object" do
      params = Hash["first_name"=>"Alan","surname"=>"Smith","email"=>"AlanS@gmail.com","password"=>"Password1","confirmpassword"=>"Password1","privilege"=>"Mentee"]
      user = User.new
      user.load(params)
      expect(user.first_name).to eq("Alan")
      expect(user.surname).to eq("Smith")
      expect(user.email).to eq("AlanS@gmail.com")
      expect(user.password).to eq("Password1")
      expect(user.privilege).to eq("Mentee")
    end
  end
  
  describe "#validPass"do
    it "returns true if password matches with confirm password" do
      user = described_class.new
      params = Hash["password"=>"Password1","confirmpassword"=>"Password1"]
      expect(user.validPass(params)).to eq(true)
    end
  end

  #describe "#getDescription"do
  #end
end