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
  params = { "first_name" => "Mentee1", "surname" => "TestDude", "email" => "Mentee1@gmail.ac.uk",
             "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentee" }
  user = User.new
  user.load(params)
  user.university = "Uni of Sheffield"
  user.degree = "Computer Science"
  user.telephone = "0114 222 9134"
  user.description = user_desc.id
  user.save_changes

  # Mentee2
  user_desc = Description.new
  user_desc.description = "Hello I do AI"
  user_desc.save_changes
  params = { "first_name" => "Mentee2", "surname" => "TestDude", "email" => "Mentee2@gmail.ac.uk",
             "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentee" }
  user = User.new
  user.load(params)
  user.university = "Uni of Sheffield"
  user.degree = "Computer Science"
  user.telephone = "0114 222 9134"
  user.description = user_desc.id
  user.save_changes

  # Mentor1
  user_desc = Description.new
  user_desc.description = "Hello I am Professor at UoS"
  user_desc.save_changes
  params = { "first_name" => "Mentor1", "surname" => "TestDudette", "email" => "Mentor1@gmail.com",
             "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentor" }
  user = User.new
  user.load(params)
  user.description = user_desc.id
  user.title = Title.new.from_name("Mrs")
  user.job_title = "Professor"
  user.industry_sector = Industry_sector.new.from_name("Teacher training and education")
  user.available_time = "Friday Afternoons"
  user.save_changes

  # Mentor2
  user_desc = Description.new
  user_desc.description = "Hello I am System Admin at UoS"
  user_desc.save_changes
  params = { "first_name" => "Mentor2", "surname" => "TestDudette", "email" => "Mentor2@gmail.com",
             "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentor" }
  user = User.new
  user.load(params)
  user.description = user_desc.id
  user.title = Title.new.from_name("Dr")
  user.job_title = "System Admin"
  user.industry_sector = Industry_sector.new.from_name("Information technology")
  user.available_time = "Any Afternoon, no weekends"
  user.save_changes

  # AH ONLY FOR EMAIL TESTING
  # -------------------------
  # Mentee
  user_desc = Description.new
  user_desc.description = "I am just a guy mentee"
  user_desc.save_changes
  params = { "first_name" => "Ariful", "surname" => "Haque", "email" => "ahaque3@sheffield.ac.uk",
             "password" => "qwe", "confirmpassword" => "qwe", "privilege" => "Mentee" }
  user = User.new
  user.load(params)
  user.university = "Uni of Sheffield"
  user.degree = "Computer Science"
  user.telephone = "0114 222 9134"
  user.description = user_desc.id
  user.save_changes

  # Mentor
  user_desc = Description.new
  user_desc.description = "I am just a guy mentor"
  user_desc.save_changes
  params = { "first_name" => "Ariful", "surname" => "Haque", "email" => "ahaque3@sheffield.ac.uk",
             "password" => "Password1", "confirmpassword" => "Password1", "privilege" => "Mentor" }

  user = User.new
  user.load(params)
  user.description = user_desc.id
  user.title = Title.new.from_name("Mr")
  user.job_title = "Streamer"
  user.industry_sector = Industry_sector.new.from_name("Media and internet")
  user.available_time = "Whenever"
  user.save_changes
  # -------------------------

  # Admin
  user_desc = Description.new
  user_desc.description = "I am founder admin"
  user_desc.save_changes
  user = User.new
  params = { "first_name" => "Ariful", "surname" => "Admin", "email" => "ahaque3@sheffield.ac.uk",
             "password" => "admin", "confirmpassword" => "admin", "privilege" => "Founder" }
  user.load(params)
  user.description = user_desc.id
  user.save_changes
  puts "Finished DB Init"
end

init_db if $PROGRAM_NAME == __FILE__
