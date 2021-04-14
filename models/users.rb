# A record of a user from the database
class User < Sequel::Model
  # .name returns the concatonated first and surname
  def name
    "#{first_name} #{surname}"
  end

  # .getDescriptions returns a string array of all of the user's
  # descriptions
  def get_descriptions
    #     puts self.description
    # Retrieves a dataset from the database
    dataset = Description.first(user_Id: description)
    #     puts dataset.nil?
    dataset.description
    #     puts description
    # if !@dataset.nil?
    #   description = dataset.description
    #   puts "here1"
    #   puts description
    #   if description == ""
    #     "here2"
    #     description = "No description found"
    #   end
    # else
    #   puts "here3"
    #   description = "No description found"
    # end
  end

  def load(params)
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.email = params.fetch("email", "").strip
    self.password = params.fetch("password", "").strip
    self.privilege = params.fetch("privilege", "").strip
    self.has_mentee = 0
    self.has_mentor = 0
  end

  def load_profile(params)
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.email = params.fetch("email", "").strip
  end

  def valid_pass(params)
    params.fetch("password") == params.fetch("confirmpassword")
  end

  def valid_pass_profile(params)
    params.fetch("newpassword", "") == params.fetch("newconfirmpassword", "")
  end
end

class Description < Sequel::Model
  def load(params)
    self.description = params.fetch("description", "").strip
  end
end
