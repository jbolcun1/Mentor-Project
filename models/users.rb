# A record of a user from the database
class User < Sequel::Model
  # .name returns the concatonated first and surname
  def name
    "#{first_name} #{surname}"
  end

  # .getDescriptions returns a string array of all of the user's
  # descriptions
  def getDescriptions(id)
    # Retrieves a dataset from the database
    dataset = Description.where(id: id)
    descriptions = []

    # Appends the description field from each record in the
    # dataset to the descriptions array
    # dataset.each do |record|
    #   descriptions << record.description

    return dataset.description

    # Returns an array of strings
    # descriptions
  end

  def load(params)
    puts params
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.email = params.fetch("email", "").strip
    self.password = params.fetch("password", "").strip
    self.privilege = params.fetch("privilege", "").strip
    self.has_mentee = 0
    self.has_mentor = 0
  end

  def validPass(params)
    params.fetch("password") == params.fetch("confirmpassword")
  end
end

class Description < Sequel::Model

  def load(params)
    puts params.fetch("description", "").strip
    self.description = params.fetch("description", "").strip
  end
end
