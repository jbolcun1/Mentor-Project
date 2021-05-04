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
  end

  describe "GET /" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/"
        expect(last_response.status).to eq(302)
      end
    end
  end
  
  describe "GET /login" do #continue from here
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

  describe "GET /logout" do
    it "has a status code of 302 (Redirect)" do
      get "/logout"
      expect(last_response.status).to eq(302)
    end
  end

  describe "GET /dashboard" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/dashboard"
        expect(last_response.status).to eq(302)
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
  end

  describe "GET /view-user" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-user"
        expect(last_response.status).to eq(302)
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
  end

  describe "GET /admin-creation" do
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
  end

  describe "GET /view-reports" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/view-reports"
        expect(last_response.status).to eq(302)
      end
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
