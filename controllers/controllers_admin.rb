get "/admin" do
  redirect "/login" unless @isLogged

  @s = "Welcome, #{user.name}. \n You have sucessfully logged in as a #{user.privilige.downcase}."
  erb :admin
end
