require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe "Form Test" do
  include Rack::Test::Methods

  describe "POST /post-login" do
    context "submission of mentee login details" do
      it "will redirect to the mentee home page" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        user.save_changes
        post "/post-login", "email" => "BSimmons@gmail.ac.uk", "password" => "Password1"
        expect(last_response.location).to include("/mentee")
        DB.from("users").delete
      end
    end
    
    context "submission of mentor login details" do
      it "will redirect to the mentor home page" do
        user = User.new(first_name: "TestPerson", surname: "Two", email: "TST@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"))
        user.save_changes
        post "/post-login", "email" => "TST@gmail.ac.uk", "password" => "Password1"
        expect(last_response.location).to include("/mentor")
        DB.from("users").delete
      end
    end
    
    context "submission of admin login details" do
      it "will redirect to the admin home page" do
        user = User.new(first_name: "TestPerson", surname: "Three", email: "TS3@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Admin"))
        user.save_changes
        post "/post-login", "email" => "TS3@gmail.ac.uk", "password" => "Password1"
        expect(last_response.location).to include("/admin")
        DB.from("users").delete
      end
    end
    
    context "submission of account details that does not exist in database" do
      it "will redirect to the login page which indicates error" do
        post "/post-login", "email" => "invalidEmail@gmail.ac.uk", "password" => "InvalidPassword"
        expect(last_response.location).to include("/login?error=1")
      end
    end
  end
end
