require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe "App Test" do
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
  
  #doesn't work
  describe "GET /profile" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/profile"
        expect(last_response.status).to eq(302)
      end
    end 
  end
  
  #doesn't work
  describe "GET /make-report" do
    context "When no user is logged in" do
      it "has a status code of 302 (Redirect)" do
        get "/make-report"
        expect(last_response.status).to eq(302)
      end
    end 
  end
  
  describe "GET /gibberish" do
    it "has a status code of 404 (Not Found)" do
      get "/gibberish"
      expect(last_response.status).to eq(404)
    end 
  end
end
