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
  if !@user.has_mentee.nil?
    @table_show2 = true
    @table_Show = false
    @mentee = User.first(id: @user.has_mentor)
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
  @errorCorrect = true if params.fetch("error", "0") == "1"
  @mentor_Id =  params[:id]
  @mentor = User.first(id: @mentor_Id)
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

post "/post-mentee-invite" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @last_Send = @user.last_send

  
  # Time class works in seconds. 86400 is one day in seconds. We store the time since they last sent an invite in seconds.
  # We check that the time time in last_Send and current time is greater then one day. If so we can do the actual invite/etc
  # If there is no last_Send we can assume they never sent an invite and then we do the invite process. 

  if !@last_Send.nil?
    time_Now = Time.new
    time_Last_send = Time.at(@last_Send.to_i)
    @mentor_Id = params.fetch("mentor_Id")
    if time_Now - time_Last_send >= 86400
      @id = request.cookies.fetch("id")
      @user = User.first(id: @id)
      @user.has_mentor = @mentor_Id
      @user.last_send = time_Now.to_i
      @user.save_changes
      # TODO: Send email 
      redirect "/mentee"
    else 
      redirect "/view-mentor?id=#{@mentor_Id}&error=1"
    end
  else
    time_Now = Time.new
    time_Last_send = Time.at(@last_Send.to_i)
    @mentor_Id = params.fetch("mentor_Id")
    @id = request.cookies.fetch("id")
    @user = User.first(id: @id)
    @user.has_mentor = @mentor_Id
    @user.last_send = time_Now.to_i
    @user.save_changes
    # Send email
    redirect "/mentee"
  end
end
