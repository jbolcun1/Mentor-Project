get "/" do
    erb :index
end

get '/login' do
    erb :login
end

get '/register' do
    erb :register
end

post "/post-login" do
    emailU = params.fetch("email")
    passwordU = params.fetch("password")
    # puts emailU
    # puts passwordU
    user = Users.first(email: emailU, :password => passwordU)
    puts user
    # if !user.empty?
    #     @foundUser = true
    #     @privilege = user.privilege
    #     if @privilege == "mentor"
    #         redirect "/mentorW"
    #     elsif @privilege == "mentee"
    #         redirect "/menteeW"
    #     else 
    #         redirect "/admin"
    #     end
    # else
    #     @foundUser = false
    # end

    "" + user.name
end
