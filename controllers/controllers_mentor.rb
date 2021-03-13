get "/mentor" do
  @id = request.cookies.fetch("id", 0)
  # puts @id
  if @id == "0" 
    redirect "/login"
  end
  @user = User.first(id: @id)

  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  erb :mentor
end

get "/mentor-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @message = "Hello prospective mentor, #{@user.name}. Please input the details below!"

  erb :mentor_register
end

post "/post-mentor-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @user.job_Title = params.fetch("job_Title", "")
  @user.industry_Sector = params.fetch("industry_Sector", "")
  puts @user.job_Title
  puts @user.industry_Sector
  @user.save_changes
  redirect "/mentor"
end