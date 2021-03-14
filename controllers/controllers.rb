get "/" do
  erb :index
end

get "/login" do
  if params.fetch("error","0") == "1"
    @errorCorrect = true
  end
  erb :login  
end

get "/register" do
  if params.fetch("error","0") == "1"
    @errorCorrect = true
  end
  erb :register
end

post "/post-login" do
  email_u = params.fetch("email")
  password_u = params.fetch("password")
  # puts emailU
  # puts passwordU
  @user = User.first(email: email_u, password: password_u)
  puts @user
  if @user != nil 
    @isLogged = false
    @privilege = @user.privilege
    #puts user.privilige
    if @privilege == "Mentee"
        @privilege = true
        @id = @user.id
        puts @id
        response.set_cookie("id", @id)
        redirect "/mentee"
    elsif @privilege == "Mentor"
      @isLogged = true
      redirect "/mentor"
    else 
        @isLogged = true
        redirect "/admin"
    end
  else
    redirect "/login?error=1"
  end

end

post "/post-register" do
  @user = User.new
  puts params.fetch("privilege", "")
  @user.load(params)
  if @user.validPass(params)
    @user.save_changes
    @id = @user.id
    response.set_cookie("id", @id)
    @privilege = @user.privilege
    if @privilege == "Mentee"
        redirect "/mentee-register"
    elsif @privilege == "Mentor"
      redirect "/mentor-register"
    end
  else 
    redirect "/register?error=1"
  end
  erb :register
end
