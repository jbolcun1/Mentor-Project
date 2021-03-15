get "/mentee" do
  # Get the id cookie. If there is one then continue. If not then redirect to login.
  @id = request.cookies.fetch("id", 0)
  if @id == "0" 
    redirect "/login"
  end
  # Find User
  @user = User.first(id: @id)
  # Check if the params have been given or not
  job_TitleM = params.fetch("job_Title", "")
  industry_SectorM = params.fetch("industry_Sector", "")
  # If given we can try and find the mentors given the params and then display them
  if job_TitleM != ""
    @table_Show = true 
    @mentors = User.where(job_Title: job_TitleM).or(industry_Sector: industry_SectorM)
    if @mentors.empty?
      # If none found then an error can show
      @error = true
    end
  end
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  # TODO Add mentee invitaion
  erb :mentee
end

post "/mentee" do
  # Will redirect to mentee with the given params 
  redirect "/mentee?job_Title=#{params[:job_Title]}&industry_Sector=#{params[:industry_Sector]}"
end

get "/mentee-register" do
  # When a mentee is registering we should add extra info
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @message = "Hello prospective Mentee, #{@user.name}. Please input the details below!"
  # TODO Add description
  erb :mentee_register
end

post "/post-mentee-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  # Get the info and add them to the user db record
  @user.degree = params.fetch("degree", "")
  puts @user.degree
  @user.save_changes
  redirect "/mentee"
end

