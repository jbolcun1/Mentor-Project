require "rspec"
require "rack/test"

require_relative "../app"

RSpec.describe "App Test" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /hello-world" do
    it "has a status code of 200 (OK)" do
      get "/hello-world"
      expect(last_response.status).to eq(200)
    end

  end
end