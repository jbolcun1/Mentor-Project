get "/mentor" do
  if !@isLogged then
      redirect "/login"
  end

  @s = "Welcome, #{user.name}. \n You have sucessfully logged in as a #{user.privilige.downcase}."
  erb :mentor
end

