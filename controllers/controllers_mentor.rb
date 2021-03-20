get "/mentor" do
  # Get the id cookie. If there is one, then continue. If not, then redirect to login.
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  @user = User.first(id: @id)
  # Display a personalised message upon a successful mentor login
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  @mentees = User.where(has_mentor: @user.id)
  if !@mentees.empty?
    @table_Show = true
  end
  # puts !@user.has_mentor.nil?
  if @user.has_mentor != 0
    @table_show2 = true
    @table_Show = false
    @mentee = User.first(id: @user.has_mentee)
  end
  # TODO: Add Mentor accept
  erb :mentor
end

get "/mentor-register" do
  # When a Mentor is registering, we should add extra info
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @message = "Hello prospective mentor, #{@user.name}. Please input the details below!"
  erb :mentor_register
end

post "/post-mentor-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  # Get the info and add them to the user db record
  @user.job_Title = params.fetch("job_Title", "")
  @user.industry_Sector = params.fetch("industry_Sector", "")
  @description = Description.new
  @description.load(params)
  @description.save_changes
  @user.description = @description.user_Id
  @user.save_changes
  redirect "/mentor"
end

get "/view-mentee" do
  @mentee_Id = params[:id]
  @mentee = User.first(id: @mentee_Id)
  # puts @mentor.description
  @description = @mentee.getDescriptions
  erb :view_mentee
end

post "/post-mentor-accept" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)

  @mentee_id = params.fetch("mentee_Id")
  @mentee = User.first(id: @mentee_id)
  @user.has_mentee = @mentee_id
  puts @user.has_mentee
  @user.has_mentor = 1
  @user.save_changes

  @mentee.has_mentee = 1
  @mentee.save_changes

  email = @mentee.email
  subject = "Your mentorship by #{@user.name} has been accepted!"
  body = "Please go back to the mentee dashbaord to see the communicative method of your mentor!"
  puts "Sending email..."
  if send_mail(email, subject, body)
    puts "Email Sent Ok."
  else
    puts "Sending failed."
  end
  redirect "/mentor"
end