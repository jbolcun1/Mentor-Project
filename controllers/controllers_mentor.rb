get "/mentor" do
  # Get the id cookie. If there is one then continue. If not then redirect to login.
  @id = request.cookies.fetch("id", 0)
  redirect "/login" if @id == "0"
  @user = User.first(id: @id)
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  # TODO: Add Mentor accept
  erb :mentor
end

get "/mentor-register" do
  # When a Mentor is registering we should add extra info
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @message = "Hello prospective mentor, #{@user.name}. Please input the details below!"
  # TODO: Add description
  erb :mentor_register
end

post "/post-mentor-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  # Get the info and add them to the user db record
  @user.job_Title = params.fetch("job_Title", "")
  @user.industry_Sector = params.fetch("industry_Sector", "")
  puts @user.job_Title
  puts @user.industry_Sector
  @user.save_changes
  redirect "/mentor"
end
