require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe Title do
  include Rack::Test::Methods
  
  describe "#load" do
    it "loads the title into a new instance of title object" do
      title = Title.new
      params = "Mr"
      title.load(params)
      expect(title.title).to eq("Mr")
    end
  end
  
  describe "#from_name" do
    it "returns the id associated with that particular title" do
      expect(Title.new.from_name("Mr")).to eq(1)
    end
  end
  
  describe "#from_id" do
    it "returns the title associated with that particular id" do
      expect(Title.new.from_id(2)).to eq("Mrs")
    end
  end
end