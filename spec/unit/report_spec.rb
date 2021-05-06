require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe Report do
  include Rack::Test::Methods
  
  describe "#load" do
    it "loads the account name, id and current time into a new instance of Report object" do
      user = User.new(email: "testperson@gmail.ac.uk")
      desc = Description.new(description: "I study english")
      report = Report.new
      
      user.save_changes
      desc.save_changes
      
      time = Time.new(2021, 01, 11, 4, 59, 21, "+02:00").to_s
      identifier = "testperson@gmail.ac.uk"
      id = user.id
      desc_id = desc.id
      
      report.load(id.to_i,identifier,desc_id,time)
      expect(report.user_id).to eq(id)
      expect(report.identifier).to eq("testperson@gmail.ac.uk")
      expect(report.description_id).to eq(desc_id)
      expect(report.date_time_made).to eq("2021-01-11 04:59:21 +0200")
      DB.from("users").delete
      DB.from("descriptions").delete
    end
  end
  
  describe "#get_description" do
    it "retrieves the description that is related to the description id assigned to the current report" do
      desc = Description.new(description: "I study History")
      desc.save_changes
      
      report = described_class.new(description_id: desc.id)
      expect(report.get_description).to eq("I study History")
      DB.from("descriptions").delete
    end
  end
  
  describe "#get_time" do
    it "returns the time this report was made" do
      time = Time.new(2021, 01, 11, 4, 59, 21, "+02:00").to_s
      report = described_class.new(date_time_made: time)
      expect(report.get_time).to eq("04:59:21 01/11/2021")
    end
  end
end