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
    @privilige = @user.privilige
    #puts user.privilige
    if @privilige == "Mentee"
        @isLogged = true
        @id = @user.id
        puts @id
        response.set_cookie("id", @id)
        redirect "/mentee"
    elsif @privilige == "Mentor"
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
    redirect "/login"
  else 
    redirect "/register?error=1"
  end
  erb :register
end
