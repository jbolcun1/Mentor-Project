require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe Description do
  include Rack::Test::Methods
  describe "#load" do
    it "loads the description of a user account into a new instance of the Description object" do
      description = Description.new
      params = { "description" => "I am a computer science student studying at The University of Sheffield." }
      description.load(params)
      expect(description.description).to eq("I am a computer science student studying at The University of Sheffield.")
    end
  end
end