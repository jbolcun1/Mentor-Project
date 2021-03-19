get "/mentee" do
  # Get the id cookie. If there is one then continue. If not then redirect to login.
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  # Find User
  @user = User.first(id: @id)
  puts @user.description
  # Check if the params have been given or not
  job_TitleM = params.fetch("job_Title", "")
  industry_SectorM = params.fetch("industry_Sector", "")
  # If given, we can try and find the mentors given the params and then display them
  if job_TitleM != ""
    @table_Show = true
    @mentors = User.where(job_Title: job_TitleM).or(industry_Sector: industry_SectorM)
    if @mentors.empty?
      # If none found, then an error can show
      @error = true
    end
  end
  # Display a personalised message upon a successful mentee login
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  # TODO: Add mentee invitaion
  erb :mentee
end

post "/mentee" do
  # Will redirect to mentee with the given params
  redirect "/mentee?job_Title=#{params[:job_Title]}&industry_Sector=#{params[:industry_Sector]}"
end

get "/mentee-register" do
  # When a mentee is registering, we should add extra info
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @message = "Hello prospective Mentee, #{@user.name}. Please input the details below!"
  erb :mentee_register
end

get "/view-mentor" do
  # TODO: Add description
  @id =  params[:id]
  @mentor = User.first(id: @id)
  # puts @mentor.description
  @description = @mentor.getDescriptions
  puts @description
  puts "here11111"
  erb :view_mentor
end

post "/post-mentee-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  # Get the info and add them to the user db record
  @user.degree = params.fetch("degree", "")

  @description = Description.new
  @description.load(params)
  @description.save_changes
  @user.description = @description.user_Id
  @user.save_changes
  redirect "/mentee"
end
