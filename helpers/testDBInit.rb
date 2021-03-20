require "require_all"

def init_db
    puts "Running DB Init"
    ENV["APP_ENV"] = "test"
    require_rel "../db/db"
    require_rel "../models"
    dataset = DB[:users]  
    dataset.delete
    dataset = DB[:descriptions]  
    dataset.delete
    # Mentee1
    user_desc = Description.new
    user_desc.description = "Hello I do Computer Science"
    user_desc.save_changes
    params = {"first_name" => "Mentee1","surname" => "TestDude", "email" => "Mentee1@gmail.com", "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentee"}
    user = User.new
    user.load(params)
    user.degree = "Computer Science"
    user.description = user_desc.user_Id
    user.save_changes

    # Mentee2
    user_desc = Description.new
    user_desc.description = "Hello I do AI"
    user_desc.save_changes
    params = {"first_name" => "Mentee2","surname" => "TestDude", "email" => "Mentee2@gmail.com", "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentee"}
    user = User.new
    user.load(params)
    user.degree = "Computer Science"
    user.description = user_desc.user_Id
    user.save_changes

    # Mentor1
    user_desc = Description.new
    user_desc.description = "Hello I am Professor at UoS"
    user_desc.save_changes
    params = {"first_name" => "Mentor1","surname" => "TestDudette", "email" => "Mentor1@gmail.com", "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentor"}
    user = User.new
    user.load(params)
    user.degree = "Computer Science"
    user.description = user_desc.user_Id
    user.job_Title = "Professor"
    user.industry_Sector = "Teacher training and education"
    user.save_changes

    # Mentor2
    user_desc = Description.new
    user_desc.description = "Hello I am System Admin  at UoS"
    user_desc.save_changes
    params = {"first_name" => "Mentor2","surname" => "TestDudette", "email" => "Mentor2@gmail.com", "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentor"}
    user = User.new
    user.load(params)
    user.degree = "Computer Science"
    user.description = user_desc.user_Id
    user.job_Title = "System Admin"
    user.industry_Sector = "Information technology"
    user.save_changes
end

if $PROGRAM_NAME == __FILE__
    init_db
end 