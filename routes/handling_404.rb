require "sinatra"
set :bind, "0.0.0.0"

not_found do
  "The page you are trying to visit does not exist. [404]"
end
