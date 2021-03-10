get "/mentee" do
  @id = request.cookies.fetch("id", 0)
  puts @id
  if @id == "0" 
    redirect "/login"
  end
  @user = User.first(id: @id)
  if @isLogged then
      redirect "/login"
  end
  puts @user
  job_TitleM = params.fetch("job_Title", "")
  industry_SectorM = params.fetch("industry_Sector", "")
  puts job_TitleM
  puts industry_SectorM

  if job_TitleM != ""
    @mentor = User.where(job_Title = job_TitleM | industry_Sector = industry_SectorM )
    if mentor != nil
      puts @mentor
    else 
      puts "Outta luck"
    end
  end
  @s = "Welcome, #{@user.name}. \n You have sucessfully logged in as a #{@user.privilige.downcase}."
  erb :mentee
end

post "/mentee" do
  redirect "/mentee?job_Title=#{params[:job_Title]}&industry_Sector=#{params[:industry_Sector]}"
end

