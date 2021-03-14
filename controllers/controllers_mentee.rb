get "/mentee" do
  @id = request.cookies.fetch("id", 0)
  # puts @id
  if @id == "0" 
    redirect "/login"
  end
  @user = User.first(id: @id)
  puts @user
  job_TitleM = params.fetch("job_Title", "")
  industry_SectorM = params.fetch("industry_Sector", "")
  # puts job_TitleM
  # puts industry_SectorM

  if job_TitleM != ""
    @table_Show = true 
    @mentors = User.where(job_Title: job_TitleM).or(industry_Sector: industry_SectorM)
    puts "Checked"
    if !@mentors.empty?
      puts "Here"
      @mentors.each do |mentor|
        puts mentor.name
      end
    else 
      @error = true
    end
  end
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilege.downcase}."
  erb :mentee
end

post "/mentee" do
  redirect "/mentee?job_Title=#{params[:job_Title]}&industry_Sector=#{params[:industry_Sector]}"
end

get "/mentee-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @message = "Hello prospective Mentee, #{@user.name}. Please input the details below!"

  erb :mentee_register
end

post "/post-mentee-register" do
  @id = request.cookies.fetch("id")
  @user = User.first(id: @id)
  @user.degree = params.fetch("degree", "")
  puts @user.degree
  @user.save_changes
  redirect "/mentee"
end

