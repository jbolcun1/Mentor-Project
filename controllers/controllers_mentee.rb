get "/mentee" do
  # Get the id cookie. If there is one then continue. If not then redirect to login.
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"

  # Find User
  @user = User.first(id: @id)

  # Check if the params have been given or not
  job_title_m = params.fetch("job_Title", "")
  industry_sector_m = params.fetch("industry_Sector", "")

  # If given, we can try and find the mentors given the params and then display them
  if job_title_m != ""
    industry_sector_id = Industry_sector.new.from_name(industry_sector_m)
    @table_show = true
    @mentors = User.where(job_Title: job_title_m).or(industry_Sector: industry_sector_id)
    if @mentors.empty?

      # If none found, then an error can show
      @error = true
    end
  end

  if @user.has_mentee != 0
    @table_show2 = true
    @mentee = User.first(id: @user.has_mentor)
  end

  # Display a personalised message upon a successful mentee login
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.get_privileges.downcase}."
  erb :mentee
end

post "/mentee" do
  # Will redirect to mentee with the given params
  redirect "/mentee?job_Title=#{params[:job_Title]}&industry_Sector=#{params[:industry_Sector]}"
end

get "/mentee-register" do
  # When a mentee is registering, we should add extra info
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"

  @user = User.first(id: @id)
  @message = "Hello prospective Mentee, #{@user.name}. Please input the details below!"
  erb :mentee_register
end

get "/view-mentor" do
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  
  @error_correct = true if params.fetch("error", "0") == "0"
  @mentor_id = params[:id]
  @mentor = User.first(id: @mentor_id)
  erb :view_mentor
end

post "/post-mentee-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)

  # Get the info and add them to the user db record
  @user.university = params.fetch("university", "")
  @user.degree = params.fetch("degree", "")
  @user.telephone = params.fetch("telephone", "")

  @description = Description.new
  @description.load(params)
  @description.save_changes
  @user.description = @description.id
  @user.save_changes
  redirect "/mentee"
end

post "/post-mentee-invite" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @last_send = @user.last_send

  # Time class works in seconds. 86400 is one day in seconds.
  # We store the time since they last sent an invite in seconds.
  # We check that the time time in last_Send and current time is greater
  # than one day. If so we can do the actual invite/etc
  # If there is no last_Send we can assume they never sent an invite and
  # then we do the invite process.
  time_now = Time.new
  if @last_send.nil?
    @mentor_id = params.fetch("mentor_Id")
    invitation_email

  else
    time_last_send = Time.at(@last_send.to_i)
    @mentor_id = params.fetch("mentor_Id")

    # sends the invitation email if more than 1 day has passed since the last
    # invite was sent. If less than 1 day, redirect to view-mentor with error
    if time_now - time_last_send >= 86_400
      invitation_email
    else
      redirect "/view-mentor?id=#{@mentor_id}&error=1"
    end
  end
end

# A small method that constructs and sends an invitation email
def invitation_email
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @user.has_mentor = @mentor_id
  time_now = Time.new
  @user.last_send = time_now.to_i
  @user.save_changes

  mentor = User.first(id: @mentor_id)
  email = mentor.email

  # Constructs an invitation email to send to a mentor
  subject = "You have been invited to a mentorship!"
  body = "This mentorship is by #{@user.name}. Below is their introductory message \n" + params[:comments]
  puts "Sending email..."

  # Sends the invitation email and redirect to mentee page
  if send_mail(email, subject, body)
    puts "Email Sent Ok."
  else
    puts "Sending failed."
  end

  redirect "/mentee"
end
