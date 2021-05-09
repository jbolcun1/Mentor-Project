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
        user = User.new(first_name: "TestPerson", surname: "Two", email: "Test2@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"))
        user.save_changes
        post "/post-login", "email" => "Test2@gmail.ac.uk", "password" => "Password1"
        expect(last_response.location).to include("/mentor")
        DB.from("users").delete
      end
    end
    
    context "submission of admin login details" do
      it "will redirect to the admin home page" do
        user = User.new(first_name: "TestPerson", surname: "Three", email: "Test3@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Admin"))
        user.save_changes
        post "/post-login", "email" => "Test3@gmail.ac.uk", "password" => "Password1"
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
    
    context "Submission of suspended account" do
      it "will redirect to the login page indicating that account is suspended" do
        user = User.new(first_name: "TestPerson", surname: "Four", email: "Test4@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Admin"), suspend: "1")
        user.save_changes
        post "/post-login", "email" => "Test4@gmail.ac.uk", "password" => "Password1"
        expect(last_response.location).to include("/login?error=2")
        DB.from("users").delete
      end
    end
  end
  
  describe "POST /post-register" do
    context "creating a mentee account" do
      it "will redirect to the /mentee-register page" do
        post "/post-register", "first_name" => "TestPerson", "surname" => "One", "email" => "Test1@gmail.ac.uk", "password" => "Password1","confirmpassword" => "Password1","privilege" => "Mentee"
        expect(last_response.location).to include("/mentee-register")
        DB.from("users").delete
      end
    end
    
    context "creating a mentor account" do
      it "will redirect to the /mentor-register page" do
        post "/post-register", "first_name" => "TestPerson", "surname" => "Two", "email" => "Test2@gmail.ac.uk", "password" => "Password1","confirmpassword" => "Password1","privilege" => "Mentor"
        expect(last_response.location).to include("/mentor-register")
        DB.from("users").delete
      end
    end
    
    context "entering different password and confirm password" do
      it "will display message 'The two password entries must be correct.'" do
        post "/post-register", "first_name" => "TestPerson", "surname" => "Two", "email" => "Test2@gmail.ac.uk", "password" => "Password1","confirmpassword" => "differentPassword","privilege" => "Mentor"
        expect(last_response.location).to include("/register?error=1")
        DB.from("users").delete
      end
    end
    
    context "mentee entering email that is not university email" do
      it "will display message 'Mentee email must be a university email." do
        post "/post-register", "first_name" => "TestPerson", "surname" => "Two", "email" => "Test2@gmail.com", "password" => "Password1","confirmpassword" => "differentPassword","privilege" => "Mentee"
        expect(last_response.location).to include("/register?error=2")
        DB.from("users").delete
      end
    end
  end
  
  describe "POST /post-profile" do
    context "changing mentee profile information" do
      it "after changes made it will redirect to /dashboard" do
        desc = Description.new(description: "I study maths")
        desc.save_changes
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        
        user.description = desc.id
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        post "/post-profile", "university" => "The University of Sheffield", "degree" => "Mathematics", "telephone" => "07515448511", "password" => ""
        expect(last_response.location).to include("/dashboard")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "changing password" do
      it "will save changes, send a notification email and redirect to /dashboard" do
        desc = Description.new(description: "I study maths")
        desc.save_changes
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        
        user.description = desc.id
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        post "/post-profile", "university" => "The University of Sheffield", "degree" => "Mathematics", "telephone" => "07515448511", "password" => "Password1","newpassword" => "Password2", "newconfirmpassword" => "Password2"
        expect(last_response.location).to include("/dashboard")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "made change to only one password field" do
      it "redirect and print an error message on screen" do
        desc = Description.new(description: "I study maths")
        desc.save_changes
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        
        user.description = desc.id
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        post "/post-profile", "university" => "The University of Sheffield", "degree" => "Mathematics", "telephone" => "07515448511", "password" => "Password1","newpassword" => "", "newconfirmpassword" => "Password2"
        expect(last_response.location).to include("/profile?error3=1")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
  end
  
  describe "POST /post-make-report" do
    context "identifier and description of what happened is posted in form" do
      it "will make new report with saved information then redirect to /dashboard" do
        user = User.new
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        post "/post-make-report", "identifier" => "Name", "description"=> "something"
        expect(last_response.location).to include("/dashboard")
        DB.from("reports").delete
        DB.from("users").delete
      end
    end
  end
  
  describe "POST /admin" do
    context "searching for an existing user" do
      it "will return the user information in a table" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson = User.new(first_name: "Mentee1", surname: "TestDude", email: "Mentee1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        post "/admin", "first_name"=>"","surname"=>"","email"=>"Mentee1@gmail.ac.uk","university"=>"","degree"=>"","job_Title"=>"","industry_Sector"=>"" 
        expect(last_response.location).to include "/admin?first_name=&surname=&email=Mentee1%40gmail.ac.uk&university=&degree=&job_Title=&industry_Sector=&empty=0"
        DB.from("users").delete
      end
    end
  end
  
  describe "POST /change-user" do
    context "changing another user's account details as a founder/admin" do
      it "after changes made it will redirect to /dashboard" do
        desc = Description.new(description: "I study maths")
        desc.save_changes
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        user.description = desc.id
        user.save_changes
        post "/change-user","id" => user.id ,"university" => "The University of Manchester", "degree" => "English", "telephone" => "07515448511", "newpassword" => ""
        expect(last_response.location).to include("/dashboard")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "changing mentor profile information" do
      it "after changes made it will redirect to /dashboard" do
        desc = Description.new(description: "I an mentor")
        desc.save_changes
        testPerson = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentor"),title:Title.new.from_name("Mrs"))
        testPerson.description = desc.id
        testPerson.save_changes
        post "/change-user?id=1", "job_title" => "Teacher", "title" => "Mrs", "industry_Sector" => "Law", "newpassword" => ""
        expect(last_response.location).to include("/dashboard")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "changing password of account" do
      it "send email and redirect to dashboard" do
        desc = Description.new(description: "I an mentor")
        desc.save_changes
        testPerson = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentor"),title:Title.new.from_name("Mrs"))
        testPerson.description = desc.id
        testPerson.save_changes
        post "/change-user?id=1", "job_title" => "Teacher", "title" => "Mrs", "industry_Sector" => "Law", "newpassword" => "Password2"
        expect(last_response.location).to include("/dashboard")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
  end
  
  describe "POST /admin-creation" do
    it "creates a new admin account" do
      founder = User.new(first_name: "founder", surname: "one", email: "Founder1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Founder"),title:Title.new.from_name("Mr"))
      founder.save_changes
      rack_mock_session.cookie_jar['id'] = founder.id
      post "/admin-creation", "first_name"=>"admin","surname"=>"one","email"=>"admin1@gmail.com","password"=>"Password1","confirmpassword"=>"Password1","privilege"=>"Admin"
      expect(last_response.location).to include "/admin-creation?success=1"
      DB.from("users").delete
    end
  
    it "redirects with an error message due to passwords not matching" do
      founder = User.new(first_name: "founder", surname: "one", email: "Founder1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Founder"),title:Title.new.from_name("Mr"))
      founder.save_changes
      rack_mock_session.cookie_jar['id'] = founder.id
      post "/admin-creation", "first_name"=>"admin","surname"=>"one","email"=>"admin1@gmail.com","password"=>"Password1","confirmpassword"=>"Password121","privilege"=>"Admin"
      expect(last_response.location).to include "/admin-creation?error=1"
      DB.from("users").delete
    end
  end
  
  describe "POST /suspension" do
    it "suspends the test account" do
      desc = Description.new(description: "I an mentee")
      desc.save_changes
      testPerson = User.new(first_name: "Mentee", surname: "One", email: "Mentee1@gmail.ac.uk", password: "Password1",
        privilege: Privilege.new.from_name("Mentee"),title:Title.new.from_name("Mrs"),suspend:0)
      testPerson.description = desc.id
      testPerson.save_changes
      post "/suspension", "id"=>testPerson.id,"suspend" => "Yes"
      expect(last_response.location).to include("/dashboard")
      DB.from("users").delete
      DB.from("descriptions").delete
    end
    
    it "unsuspends the test account" do
      desc = Description.new(description: "I an mentee")
      desc.save_changes
      testPerson = User.new(first_name: "Mentee", surname: "One", email: "Mentee1@gmail.ac.uk", password: "Password1",
        privilege: Privilege.new.from_name("Mentee"),title:Title.new.from_name("Mrs"),suspend:1)
      testPerson.description = desc.id
      testPerson.save_changes
      post "/suspension", "id"=>testPerson.id,"suspend" => "Yes"
      expect(last_response.location).to include("/dashboard")
      DB.from("users").delete
      DB.from("descriptions").delete
    end
  end
  
  describe "POST /post-mentee-register" do
    it "will add further mentee information to mentee account then redirect to /mentee" do
      testPerson = User.new(first_name: "Mentee", surname: "One", email: "Mentee1@gmail.ac.uk", password: "Password1",
        privilege: Privilege.new.from_name("Mentee"),title:Title.new.from_name("Mrs"),suspend:1)
      testPerson.save_changes
      rack_mock_session.cookie_jar['id'] = testPerson.id
      post "/post-mentee-register", "university"=>"The University of Sheffield", "degree"=>"Physics","telephone"=>"07768194123","description"=>"I am new student"
      expect(last_response.location).to include ("/mentee")
      DB.from("users").delete
    end
  end
  
  describe "POST /post-mentee-invite" do
    it "will add further mentee information to mentee account then redirect to /mentee" do
      testPerson = User.new(first_name: "Mentee", surname: "One", email: "Mentee1@gmail.ac.uk", password: "Password1",
        privilege: Privilege.new.from_name("Mentee"),title:Title.new.from_name("Mrs"),last_send:Time.now)
      testPerson.save_changes
      rack_mock_session.cookie_jar['id'] = testPerson.id
      post "/post-mentee-register", "university"=>"The University of Sheffield", "degree"=>"Physics","telephone"=>"07768194123","description"=>"I am new student"
      expect(last_response.location).to include ("/mentee")
      DB.from("users").delete
    end
  end
  
  describe "POST /post-mentor-register" do
    it "will add further mentor information to mentor account then redirect to /mentor" do
      testPerson = User.new(first_name: "Mentor", surname: "One", email: "Mentor1@gmail.ac.uk", password: "Password1",
        privilege: Privilege.new.from_name("Mentor"))
      testPerson.save_changes
      rack_mock_session.cookie_jar['id'] = testPerson.id
      post "/post-mentor-register","title"=>"Mrs", "job_Title"=>"Lawyer","industry_Sector"=>"Law","description"=>"text"
      expect(last_response.location).to include ("/mentor")
      DB.from("users").delete
    end
  end
  
  describe "POST /post-mentor-accept" do
    context "mentor accepts the mentee" do
      it "sends email and redirects to /mentor" do
        mentor = User.new(first_name: "mentor", surname: "one", email: "mentor1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentor"),title:Title.new.from_name("Mr"))
        desc = Description.new(description: "Text")
        desc.save_changes
        mentor.save_changes
        mentee = User.new(first_name: "mentee", surname: "one", email: "mentee1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentee"),title:Title.new.from_name("Mr"))
        mentee.description = desc.id
        mentee.save_changes
        rack_mock_session.cookie_jar['id'] = mentor.id
        post "/post-mentor-accept", "mentee_Id"=>mentee.id, "decision"=>"accept"
        expect(last_response.location).to include ("/mentor")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "mentor rejects the mentee" do
      it "sends email and redirects to /mentor" do
        mentor = User.new(first_name: "mentor", surname: "one", email: "mentor1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentor"),title:Title.new.from_name("Mr"))
        desc = Description.new(description: "Text")
        desc.save_changes
        mentor.save_changes
        mentee = User.new(first_name: "mentee", surname: "one", email: "mentee1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentee"),title:Title.new.from_name("Mr"))
        mentee.description = desc.id
        mentee.save_changes
        rack_mock_session.cookie_jar['id'] = mentor.id
        post "/post-mentor-accept", "mentee_Id"=>mentee.id, "decision"=>"reject"
        expect(last_response.location).to include ("/mentor")
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
  end
end
