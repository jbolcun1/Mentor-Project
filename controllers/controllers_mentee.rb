get "/mentee" do
  @user = Users.first(id: params[:id])
  if @isLogged then
      redirect "/login"
  end
  
  puts @user
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilige.downcase}."
  erb :mentee
end

