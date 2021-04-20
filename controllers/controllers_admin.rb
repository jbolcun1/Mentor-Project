get "/admin" do
  @id = request.cookies.fetch("id", "0")
  redirect "/login" if @id == "0"
  @user = User.first(id: @id)

  @founder = true if @user.privilege = "Founder"

  empty = params.fetch("empty", "1")
  if empty != "1"
    first_name = params.fetch("first_name", "0")
    surname = params.fetch("surname", "0")
    email = params.fetch("email", "0")
    university = params.fetch("university", "0")
    degree = params.fetch("degree", "0")
    job_title = params.fetch("job_Title", "0")
    industry_sector = params.fetch("industry_Sector", "0")
    @user_list = User.where(first_name: first_name).or(surname: surname).or(email: email)
                     .or(university: university).or(degree: degree)
                     .or(job_title: job_title).or(industry_Sector: industry_sector)
    @table_show = true
  end

  # Display a personalised message upon a successful admin login
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  erb :admin
end

post "/admin" do
  empty = "1"
  puts params
  params.each do |_paramName , value|
    empty = "0" unless value.empty?
  end
  params[:empty] = empty
  querystring = URI.encode_www_form(params)
  puts querystring
  redirect "/admin?#{querystring}"
end

get "/view-user" do
  puts "here"
  @user_id = params[:id]
  @view_user = User.first(id: @user_id)
  @description = @view_user.get_descriptions

  case @view_user.privilege
  when "Mentee"
    @mentee_profile = true
  when "Mentor"
    @mentor_profile = true
  end

  erb :view_user
end
