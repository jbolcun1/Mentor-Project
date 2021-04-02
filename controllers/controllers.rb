get "/" do
  @id = request.cookies.fetch("id", "0")
  redirect "/index" if @id == "0"
  @user = User.first(id: @id)
  # Check if a user is found. If not, we redirect back to login with an error
  if @user.nil?
    redirect "/index"
  else
    @privilege = @user.privilege
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
  @errorCorrect = true if params.fetch("error", "0") == "1"
  erb :login
end

get "/logout" do 
  response.delete_cookie("id")
  redirect "/index"
end

get "/index" do
  @errorCorrect = true if params.fetch("error", "0") == "1"
  erb :index
end

get "/about" do
  @errorCorrect = true if params.fetch("error", "0") == "1"
  erb :about
end

get "/register" do
  @errorCorrect = true if params.fetch("error", "0") == "1"
  erb :register
end

post "/post-login" do
  email_u = params.fetch("email")
  password_u = params.fetch("password")

  # Try to find the user with infomation given
  @user = User.first(email: email_u, password: password_u)
  # Check if a user is found. If not, we redirect back to login with an error
  if @user.nil?
    redirect "/login?error=1"
  else
    @privilege = @user.privilege
    @id = @user.id
    response.set_cookie("id", @id)
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
end

post "/post-register" do
  @user = User.new
  # Load given info into a new user object
  @user.load(params)
  # Check that the given info is valid.
  # If valid, redirect associated page to register more infomation
  # If not, redirect to register page with error
  if @user.validPass(params)
    @user.save_changes
    @id = @user.id
    response.set_cookie("id", @id)
    @privilege = @user.privilege
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
  redirect "/index" if @id == "0"
  @user = User.first(id: @id)
  # Check if a user is found. If not, we redirect back to login with an error
  if @user.nil?
    redirect "/index"
  else
    @privilege = @user.privilege
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
end

get "/profile" do
  # TODO: Add descriptions
  @id = request.cookies.fetch("id", "0")
  @user = User.first(id: @id)
  @privilege = @user.privilege
  @error_correct = true if params.fetch("error1", "0") == "1"
  @error_correct2 = true if params.fetch("error2", "0") == "1"
  @error_correct3 = true if params.fetch("error3", "0") == "1"
  # Find out what type of user they are and then redirect them to the correct page
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
  @user.loadProfile(params)

  case @user.privilege
  when "Mentee"
    @user.university = params.fetch("university", "")
    @user.degree = params.fetch("degree", "")
    @user.telephone = params.fetch("telephone", "")
    @user.save_changes
  when "Mentor"
    @user.title = params.fetch("title", "")
    @user.job_Title = params.fetch("job_Title", "")
    @user.industry_Sector = params.fetch("industry_Sector", "")
    @user.save_changes
  end
  if params.fetch("password") != ""
    if params.fetch("password") != @user.password
      redirect "/profile?error2=1"
    end
    if params.fetch("newpassword") != "" && params.fetch("newconfirmpassword") != ""
      
      if @user.validPassProfile(params)
        @user.password = params.fetch("newpassword")
        @user.save_changes
        redirect "/dashboard"
      else
        redirect "/profile?error1=1"
      end
    else
      redirect "/profile?error3=1"
    end
  else
    @user.save_changes
    redirect "/dashboard"
  end
end
