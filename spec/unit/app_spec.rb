require "rspec"
require "rack/test"

require_relative "../spec_helper"

RSpec.describe "App Test" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /" do
    it "has a status code of 302 (Redirect)" do
      get "/"
      expect(last_response.status).to eq(302)
    end
  end
end
