get "/" do
  @id = request.cookies.fetch("id", "0")
  redirect "/index" if @id == "0"
  @user = User.first(id: @id)

  # Check if a user is found. If not, we redirect back to login with an error
  if @user.nil?
    redirect "/index"
  else
    @privilege = @user.get_privileges
      
    # Find out what type of user they are and then redirect them to the correct page
    case @privilege
    when "Mentee"
      redirect "/mentee"
    when "Mentor"
      redirect "/mentor"
    else
      redirect "/admin"
    end
  end
    
  erb :index
end

get "/login" do
  # Errors will show if the are passed from the post login
  @error_correct = true if params.fetch("error", "0") == "1"
  @error_correct2 = true if params.fetch("error", "0") == "2"
  erb :login
end

get "/logout" do
  response.delete_cookie("id")
  redirect "/index"
end

get "/index" do
  @error_correct = true if params.fetch("error", "0") == "1"
  erb :index
end

get "/about" do
  @error_correct = true if params.fetch("error", "0") == "1"
  erb :about
end

get "/register" do
  @error_correct = true if params.fetch("error", "0") == "1"
  @error_correct2 = true if params.fetch("error", "0") == "2"
  erb :register
end

post "/post-login" do
  email_u = params.fetch("email")
  password_u = params.fetch("password")

  # Try to find the user with information given
  @user = User.first(email: email_u, password: password_u)
    
  # Check if a user is found. If not, we redirect back to login with an error
  if @user.nil?
    redirect "/login?error=1"
  else
    redirect "/login?error=2" if @user.suspend == 1
    @privilege = @user.get_privileges
    @id = @user.id
    response.set_cookie("id", @id)
      
    # Find out what type of user they are and then redirect them to the 
    # correct page
    case @privilege
    when "Mentee"
      redirect "/mentee"
    when "Mentor"
      redirect "/mentor"
    else
      redirect "/admin"
    end
  end
end

post "/post-register" do
  @user = User.new
  # Load given info into a new user object
  @user.load(params)
  # Check that the given info is valid.
  # If valid, redirect associated page to register more information

  redirect "/register?error=2" if @user.get_privileges == ("Mentee") && !@user.email.end_with?(".ac.uk")

  # If not, redirect to register page with error
  if @user.valid_pass(params)
    @user.save_changes
    @id = @user.id
    response.set_cookie("id", @id)
    @privilege = @user.get_privileges
    case @privilege
    when "Mentee"
      redirect "/mentee-register"
    when "Mentor"
      redirect "/mentor-register"
    end
  else
    redirect "/register?error=1"
  end
    
  erb :register
end

get "/dashboard" do
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  @user = User.first(id: @id)

  # Check if a user is found. If not, we redirect back to login with an error
  if @user.nil?
    redirect "/index"
  else
    @privilege = @user.get_privileges
      
    # Find out what type of user they are and then redirect them to the 
    # correct page
    case @privilege
    when "Mentee"
      redirect "/mentee"
    when "Mentor"
      redirect "/mentor"
    when "Founder", "Admin"
      redirect "/admin"
    end
  end
end

get "/profile" do
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  @user = User.first(id: @id)
  @founder = true if @user.get_privileges == "Founder"
  @privilege = @user.get_privileges
  @error_correct = true if params.fetch("error1", "0") == "1"
  @error_correct2 = true if params.fetch("error2", "0") == "1"
  @error_correct3 = true if params.fetch("error3", "0") == "1"
    
  # Find out what type of user they are and then show the correct info panels for that user
  case @privilege
  when "Mentee"
    @mentee_profile = true
  when "Mentor"
    @mentor_profile = true
  else
    @admin_profile = true
  end
    
  erb :profile
end

post "/post-profile" do
  @id = request.cookies.fetch("id", "0")
  @user = User.first(id: @id)
  @user.load_profile(params)

  # Depending on the user privileges we may have to change different things
  case @user.get_privileges
  when "Mentee"
    @user.university = params.fetch("university", "")
    @user.degree = params.fetch("degree", "")
    @user.telephone = params.fetch("telephone", "")
    @user.save_changes
  when "Mentor"
    @user.title = Title.new.from_name(params.fetch("title", ""))
    @user.job_title = params.fetch("job_Title", "")
    @user.industry_sector = Industry_sector.new.from_name(params.fetch("industry_Sector", ""))
    @user.available_time = params.fetch("available_Time", "")
    @user.save_changes
  end
  @description = Description.first(id: @user.description)
  @description.description = params.fetch("description", "")
  @description.save_changes

  # If the password has not been attempted to change we can redirect to the dashboard
  if params.fetch("password") == ""
    @user.save_changes
    redirect "/dashboard"
  else

    # Throws an error to the profile page if the password is not correct
    redirect "/profile?error2=1" if params.fetch("password") != @user.password

    # Updates a users password to "newpassword" and sends an email to 
    # notify them
    if params.fetch("newpassword") != "" && params.fetch("newconfirmpassword") != ""
      if @user.valid_pass_profile(params)
        @user.password = params.fetch("newpassword")
        @user.save_changes
        date_time = Time.new
        email = @user.email
        subject = "Your password changed on the eMentoring website"
        body = "Your password was changed at #{date_time.strftime('%R')} on #{date_time.strftime('%A %D')}"
        puts "Sending email..."

        # Sends the notification email to the user. redirect to dashboard 
        # if the email sent successfully or to their profile page if not
        if send_mail(email, subject, body)
          puts "Email Sent Ok."
        else
          puts "Sending failed."
        end
        redirect "/dashboard"
      else
        redirect "/profile?error1=1"
      end
    else
      redirect "/profile?error3=1"
    end
  end
end

get "/make-report" do
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  erb :make_report
end

post "/post-make-report" do
  id = request.cookies.fetch("id", "0")
  puts params
  description = Description.new
  description.load(params)
  description.save_changes
  identifier = params.fetch("identifier", "0")
  puts identifier
  time = Time.new.to_s
  report = Report.new
  report.load(id.to_i, identifier, description.id, time)
  description.save_changes
  report.save_changes
  redirect "/dashboard"
end
