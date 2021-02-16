require "sinatra"
require "sinatra/reloader"
set :bind, "0.0.0.0"

get "/hello-world" do
    erb :index
end