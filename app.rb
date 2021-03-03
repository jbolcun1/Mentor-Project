require "sinatra"
require "sinatra/reloader"
require "require_all"

set :bind, "0.0.0.0"

require_relative "db/db"

require_all "controllers"
require_all "models"
