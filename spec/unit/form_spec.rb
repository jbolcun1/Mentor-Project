require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe "Form Test" do
  include Rack::Test::Methods
  
  describe "POST /post-login" do
    context "submission of mentee login details" do
      it "will redirect to the mentee home page" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1", privilege: Privilege.new.from_name("Mentee"))
        user.save_changes
        post "/post-login", "email" => "BSimmons@gmail.ac.uk", "password" => "Password1"
        expect(last_response.location).to include("/mentee")
        DB.from("users").delete
      end
    end
  end
end