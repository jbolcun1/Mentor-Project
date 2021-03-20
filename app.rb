require "sinatra"
require "sinatra/reloader"
require "require_all"

set :bind, "0.0.0.0"

include ERB::Util

require_relative "db/db"

require_rel "controllers"
require_rel "models"
require_rel "helpers"
