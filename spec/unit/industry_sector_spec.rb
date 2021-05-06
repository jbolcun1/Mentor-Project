require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe Industry_sector do
  include Rack::Test::Methods
  
  describe "#load" do
    it "loads the industry sector into a new instance of Industry_sector object" do
      industrySector = described_class.new
      params = "Accountancy, banking and finance"
      industrySector.load(params)
      expect(industrySector.sector).to eq("Accountancy, banking and finance")
    end
  end
  
  describe "#from_name" do
    it "returns the id associated with that particular industry sector" do
      expect(Industry_sector.new.from_name("Business, consulting and management")).to eq(2)
    end
  end
  
  describe "#from_id" do
    it "returns the industry sector associated with that particular id" do
      expect(Industry_sector.new.from_id(18)).to eq("Recruitment and HR")
    end
  end
end
  