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
  
  #describe "#load" do
    #it "loads a new user into the database" do
    #end
  #end
  
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