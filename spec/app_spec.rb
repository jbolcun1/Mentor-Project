require "rspec"
require "rack/test"

require_relative "../app"

RSpec.describe "App Test" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /" do
    it "has a status code of 200 (OK)" do
      get "/"
      expect(last_response.status).to eq(200)
    end
  end
end
