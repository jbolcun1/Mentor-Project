get "/admin" do
  redirect "/login" unless @isLogged

  # Display a personalised message upon a successful admin login
  @s = "Welcome, #{user.name}. \n You have sucessfully logged in as a #{user.privilige.downcase}."
  erb :admin
end
