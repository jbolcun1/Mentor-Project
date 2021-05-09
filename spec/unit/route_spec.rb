require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe "Route Test" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /index" do 
    it "has status code of 200 (OK)" do
      get "/index"
      expect(last_response.status).to eq(200)
    end

    it "says 'Helping you to find the perfect mentor Quickly. Effiently.'" do
      get "/index"
      expect(last_response.body).to include "Helping you to find the perfect mentor"
    end
  end

  describe "GET /about" do 
    it "has a status code of 200 (OK)" do
      get "/about"
      expect(last_response.status).to eq(200)
    end

    it "says 'How the E-mentor scheme works:'" do
      get "/about"
      expect(last_response.body).to include "How the E-mentor scheme works:"
    end
  end

  describe "GET /register" do 
    it "has a status code of 200 (OK)" do
      get "/register"
      expect(last_response.status).to eq(200)
    end

    it "says 'Please fill in the fields below to complete the registration process'" do
      get "/register"
      expect(last_response.body).to include "Please fill in the fields below to complete the registration process"
    end
    
    context "entering two different passwords for password and confirm password" do
      it "will print 'The two password entries must be correct.'" do
        get "/register?error=1"
        expect(last_response.body).to include "The two password entries must be correct."
      end
    end
    
    context "Mentee entering an email that is not a university email" do
      it "will say 'Mentee email must be a university email.'" do
        get "/register?error=2"
        expect(last_response.body).to include "Mentee email must be a university email."
      end
    end
  end

  describe "GET /" do 
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/"
        expect(last_response.status).to eq(302)
      end
    end  
    
    context "logged in as mentee account" do
      it "will redirect to /mentee" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/"
        expect(last_response.location).to include("/mentee")
        DB.from("users").delete
      end
    end  
    
    context "logged in as mentor account" do
      it "will redirect to /admin" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/"
        expect(last_response.location).to include("/mentor")
        DB.from("users").delete
      end
    end 
    
    context "logged in as admin account" do
      it "will redirect to /admin" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Admin"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/"
        expect(last_response.location).to include("/admin")
        DB.from("users").delete
      end
    end 
    
    context "user doesn't exist" do
      it "will redirect to /index" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = -10
        get "/"
        expect(last_response.location).to include("/index")
        DB.from("users").delete
      end
    end 
  end
  
  describe "GET /login" do #done
    it "has a status code of 200 (OK)" do
      get "/login"
      expect(last_response.status).to eq(200)
    end
    
    context "account details inputted are not found" do
      it "will load the page with an error message" do
        get "/login?error=1"
        expect(last_response.body).to include("There has been an error try again")
      end
    end
    
    context "account details inputted are not found" do
      it "will load the page with an error message" do
        get "/login?error=2"
        expect(last_response.body).to include("You have been suspended")
      end
    end
  end

  describe "GET /logout" do #done
    it "has a status code of 302 (Redirect)" do
      get "/logout"
      expect(last_response.status).to eq(302)
    end
  end

  describe "GET /dashboard" do #done
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/dashboard"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "logged in as mentee account" do
      it "will redirect to /mentee" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/dashboard"
        expect(last_response.location).to include("/mentee")
        DB.from("users").delete
      end
    end  
    
    context "logged in as mentor account" do
      it "will redirect to /admin" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/dashboard"
        expect(last_response.location).to include("/mentor")
        DB.from("users").delete
      end
    end 
    
    context "logged in as admin account" do
      it "will redirect to /admin" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Admin"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/dashboard"
        expect(last_response.location).to include("/admin")
        DB.from("users").delete
      end
    end 
    
    context "user doesn't exist" do
      it "will redirect to /index" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = -10
        get "/dashboard"
        expect(last_response.location).to include("/index")
        DB.from("users").delete
      end
    end 
  end

  describe "GET /profile" do 
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/profile"
        expect(last_response.status).to eq(302)
      end
    end
  end

  describe "GET /make-report" do 
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/make-report"
        expect(last_response.status).to eq(302)
      end
    end
  end

  describe "GET /admin" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/admin"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "logged in as a founder" do
      it "will have status code of 200 (OK)" do
        user = User.new(first_name: "Bonny", surname: "Simmons", email: "BSimmons@gmail.ac.uk", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson = User.new(first_name: "Mentee1", surname: "TestDude", email: "Mentee1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        user.save_changes
        rack_mock_session.cookie_jar['id'] = user.id
        get "/admin","empty"=>0, "first_name"=>"","surname"=>"","email"=>"Mentee1@gmail.ac.uk","university"=>"","degree"=>"","job_Title"=>"","industry_Sector"=>"Law" 
        expect(last_response.status).to eq(200)
        DB.from("users").delete
      end
    end
  end

  describe "GET /view-user" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-user"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "viewing a mentee account" do
      it "will have a status code of 200 (OK)" do
        testPerson = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson2 = User.new(first_name: "Mentee1", surname: "TestDude2", email: "Mentee1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        desc = Description.new(description:"some text")
        desc.save_changes
        testPerson.save_changes
        testPerson2.description = desc.id
        testPerson2.save_changes
        
        rack_mock_session.cookie_jar['id'] = testPerson.id
        get "/view-user", "id"=> testPerson2.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "viewing a mentor account" do
      it "will have a status code of 200 (OK)" do
        testPerson = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson2 = User.new(first_name: "Mentor1", surname: "TestDude2", email: "Mentor1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"), industry_sector: Industry_sector.new.from_name("Law"))
        desc = Description.new(description:"some text")
        desc.save_changes
        testPerson.save_changes
        testPerson2.description = desc.id
        testPerson2.save_changes
        
        rack_mock_session.cookie_jar['id'] = testPerson.id
        get "/view-user", "id"=> testPerson2.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
  end

  describe "GET /change-user" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/change-user"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "changing a Mentee account" do
      it "will have a status code of 200 (OK)" do
        testPerson = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson2 = User.new(first_name: "Mentee1", surname: "TestDude2", email: "Mentee1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        desc = Description.new(description:"some text")
        desc.save_changes
        testPerson.save_changes
        testPerson2.description = desc.id
        testPerson2.save_changes
        
        rack_mock_session.cookie_jar['id'] = testPerson.id
        get "/change-user", "id"=> testPerson2.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "changing a a Mentor account" do
      it "will have a status code of 200 (OK)" do
        testPerson = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"),title:Title.new.from_name("Mr"),industry_sector:Industry_sector.new.from_name("Law"))
        testPerson2 = User.new(first_name: "Mentor1", surname: "TestDude2", email: "Mentor1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentor"), industry_sector: Industry_sector.new.from_name("Law"),title:Title.new.from_name("Mr"))
        desc = Description.new(description:"some text")
        desc.save_changes
        testPerson.save_changes
        testPerson2.description = desc.id
        testPerson2.save_changes
        
        rack_mock_session.cookie_jar['id'] = testPerson.id
        get "/change-user", "id"=> testPerson2.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
    context "changing a admin account" do
      it "will have a status code of 200 (OK)" do
        testPerson = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson2 = User.new(first_name: "Admin1", surname: "TestDude2", email: "Admin1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Admin"))
        desc = Description.new(description:"some text")
        desc.save_changes
        testPerson.save_changes
        testPerson2.description = desc.id
        testPerson2.save_changes
        
        rack_mock_session.cookie_jar['id'] = testPerson.id
        get "/change-user", "id"=> testPerson2.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
  end

  describe "GET /admin-creation" do
    context "When founder account is logged in" do
      it "has a status code of 200 (OK)" do
        testPerson = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        testPerson.save_changes
        rack_mock_session.cookie_jar['id'] = testPerson.id
        get "/admin-creation"
        expect(last_response.status).to eq(200)
        DB.from("users").delete
      end
    end
    
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/admin-creation"
        expect(last_response.status).to eq(302)
      end
    end
  end

  describe "GET /suspension" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/suspension"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "When founder is logged in" do
      it "has a status code of 200 (OK)" do
        founder = User.new(first_name: "Founder1", surname: "TestDude", email: "Founder1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Founder"))
        founder.save_changes
        testGuy = User.new(first_name: "Mentee1", surname: "TestDude", email: "Mentee1@gmail.ac.uk	", password: "Password1",
                        privilege: Privilege.new.from_name("Mentee"))
        desc = Description.new(description: "I am a mentee")
        desc.save_changes
        testGuy.description = desc.id
        testGuy.save_changes
        rack_mock_session.cookie_jar['id'] = founder.id
        get "/suspension", "id"=>testGuy.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
  end

  describe "GET /view-reports" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-reports"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "When founder is logged in" do
      it "has a status code of 200 (OK)" do
        founder = User.new(first_name: "founder", surname: "one", email: "Founder1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Founder"),title:Title.new.from_name("Mr"))
        founder.save_changes
        rack_mock_session.cookie_jar['id'] = founder.id
        get "/view-reports"
        expect(last_response.status).to eq(200)
        DB.from("users").delete
      end
    end
  end
  
  describe "GET /view-report-detail" do
    context "When founder account is logged in" do
      it "has a status code of 200 (OK)" do
        founder = User.new(first_name: "founder", surname: "one", email: "Founder1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Founder"),title:Title.new.from_name("Mr"))
        founder.save_changes
        rack_mock_session.cookie_jar['id'] = founder.id
        get "/view-report-detail", "id"=>0
        expect(last_response.status).to eq(200)
        DB.from("users").delete
      end
    end
    
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-report-detail"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /delete-report" do
    it "has a status code of 302 (Redirect)" do
      founder = User.new(first_name: "founder", surname: "one", email: "Founder1@gmail.ac.uk", password: "Password1",
        privilege: Privilege.new.from_name("Founder"),title:Title.new.from_name("Mr"))
      founder.save_changes
      report = Report.new
      report.save_changes
      rack_mock_session.cookie_jar['id'] = founder.id
      get "/delete-report", "id" => report.id
      expect(last_response.status).to eq(302)
      DB.from("users").delete
      DB.from("reports").delete
    end
  end
  
  describe "GET /mentee" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/mentee"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /mentee-register" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/mentee-register"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /view-mentor" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-mentor"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /mentor" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/mentor"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /mentor-register" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/mentor-register"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /view-mentee" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-mentee"
        expect(last_response.status).to eq(302)
      end
    end
    
    context "When mentor is logged in" do
      it "has a status code of 200 (OK)" do
        mentor = User.new(first_name: "mentor", surname: "one", email: "mentor1@gmail.ac.uk", password: "Password1",
          privilege: Privilege.new.from_name("Mentor"),title:Title.new.from_name("Mr"))
        desc = Description.new
        desc.save_changes
        mentor.save_changes
        mentee = User.new
        mentee.description = desc.id
        mentee.save_changes
        rack_mock_session.cookie_jar['id'] = mentor.id
        get "/view-mentee", "id"=>mentee.id
        expect(last_response.status).to eq(200)
        DB.from("users").delete
        DB.from("descriptions").delete
      end
    end
    
  end

  describe "GET /gibberish" do
    context "typing in random stuff into the url" do
      it "has a status code of 404 (Not Found)" do
        get "/gibberish"
        expect(last_response.status).to eq(404)
      end
    end
  end
end
