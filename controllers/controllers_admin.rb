get "/admin" do
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  @user = User.first(id: @id)

  @founder = true if @user.get_privileges == "Founder"

  empty = params.fetch("empty", "1")
  if empty != "1"
    first_name = params.fetch("first_name", "0")
    surname = params.fetch("surname", "0")
    email = params.fetch("email", "0")
    university = params.fetch("university", "0")
    degree = params.fetch("degree", "0")
    job_title = params.fetch("job_Title", "0")
    industry_sector = params.fetch("industry_Sector", "0")
    if industry_sector != ""
      industry_sector_id = Industry_sector.new.from_name(industry_sector)
    else 
      industry_sector_id = 0
    end
    @user_list = User.where(first_name: first_name).or(surname: surname).or(email: email)
                     .or(university: university).or(degree: degree)
                     .or(job_title: job_title).or(industry_sector: industry_sector_id)
    @table_show = true
  end

  # Display a personalised message upon a successful admin login
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.get_privileges.downcase}."
  erb :admin
end

post "/admin" do
  empty = "1"
  puts params
  params.each do |_paramName, value|
    empty = "0" unless value.empty?
  end
  params[:empty] = empty
  querystring = URI.encode_www_form(params)
  puts querystring
  redirect "/admin?#{querystring}"
end

get "/view-user" do
  @id = request.cookies.fetch("id", "0")
  @user = User.first(id: @id)
  @user_id = params[:id]
  @view_user = User.first(id: @user_id)

  case @view_user.get_privileges
  when "Mentee"
    @mentee_profile = true
  when "Mentor"
    @mentor_profile = true
  end

  erb :view_user
end

get "/change-user" do
  @id = request.cookies.fetch("id", "0")
  @user = User.first(id: @id)

  @user_id = params[:id]
  @change_user = User.first(id: @user_id)
  @privilege = @change_user.get_privileges
  @description = Description.first(user_Id: @user.description)

  case @privilege
  when "Mentee"
    @mentee_profile = true
  when "Mentor"
    @mentor_profile = true
  else
    @admin_profile = true
  end
  erb :profile_user_change
end

post "/change-user" do
  @id = params[:id]
  @user = User.first(id: @id)
  @user.load_profile(params)

  case @user.get_privileges
  when "Mentee"
    @user.university = params.fetch("university", "")
    @user.degree = params.fetch("degree", "")
    @user.telephone = params.fetch("telephone", "")
  when "Mentor"
    @user.title = Title.new.from_name(params.fetch("title", ""))
    @user.job_title = params.fetch("job_Title", "")
    @user.industry_sector = Industry_sector.new.from_name(params.fetch("industry_Sector", ""))
    @user.available_time = params.fetch("available_Time", "")
  end

  @description = Description.first(id: @user.description)
  @description.description = params.fetch("description", "")

  if params.fetch("newpassword") != ""
    @user.password = params.fetch("newpassword")
    date_time = Time.new
    email = @user.email
    subject = "Your password changed on the eMentoring website by an admin"
    body = "Your password was changed at #{date_time.strftime('%R')} on #{date_time.strftime('%A %D')}"
    puts "Sending email..."
    if send_mail(email, subject, body)
      puts "Email Sent Ok."
    else
      puts "Sending failed."
    end
  end
  @description.save_changes
  @user.save_changes
  redirect "/dashboard"
end

get "/admin-creation" do
  @id = request.cookies.fetch("id", "0")
  @user = User.first(id: @id)
  @error_correct = true if params.fetch("error", "0") == "1"
  @success = true if params.fetch("success", "0") == "1"

  puts @success
  erb :admin_creation
end

post "/admin-creation" do
  @new_user = User.new
  # Load given info into a new user object
  @new_user.load(params)
  # Check that the given info is valid.
  # If valid, redirect associated page
  # If not, redirect to register page with error
  if @new_user.valid_pass(params)
    @description = Description.new
    @description.load("description" => " I am a #{@new_user.get_privileges.downcase}")
    @description.save_changes
    @new_user.description = @description.id
    @new_user.save_changes
    redirect "/admin-creation?success=1"
  else
    redirect "/admin-creation?error=1"
  end
  erb :admin_creation
end

get "/suspension" do
  @id = request.cookies.fetch("id", "0")
  @user = User.first(id: @id)
  @user_id = params[:id]
  @view_user = User.first(id: @user_id)
  @description = @view_user.get_descriptions
  puts @view_user.suspend
  @suspended = true if @view_user.suspend == 1
  erb :suspension
end

post "/suspension" do
  @id = params[:id]
  @user = User.first(id: @id)
  date_time = Time.new
  email = @user.email
  case @user.suspend
  when 1
    @user.suspend = 0
    subject = "You were unsuspended by an admin on the eMentoring website"
    body = "You unsuspended at #{date_time.strftime('%R')} on #{date_time.strftime('%A %D')}"
  when 0
    subject = "You were suspended by an admin on the eMentoring website"
    body = "You suspended at #{date_time.strftime('%R')} on #{date_time.strftime('%A %D')}"
    @user.suspend = 1
  end
  puts "Sending email..."
  if send_mail(email, subject, body)
    puts "Email Sent Ok."
  else
    puts "Sending failed."
  end
  @user.save_changes
  redirect "/dashboard"
end
