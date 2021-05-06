require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe Privilege do
  include Rack::Test::Methods
  
  describe "#load" do
    it "loads the privilege into a new instance of Privilege object" do
      privilege = described_class.new
      params = "Mentee"
      privilege.load(params)
      expect(privilege.privilege).to eq("Mentee")
    end
  end
  
  describe "#from_name" do
    it "returns the id associated with that particular privilege" do
      expect(Privilege.new.from_name("Mentor")).to eq(3)
    end
  end
  
  describe "#from_id" do
    it "returns the privilege associated with that particular id" do
      expect(Privilege.new.from_id(4)).to eq("Admin")
    end
  end
end
  
  