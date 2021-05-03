# A record of a user from the database
class User < Sequel::Model
  # .name returns the concatonated first and surname
  def name
    "#{first_name} #{surname}"
  end

  # .getDescriptions returns a string array of all of the user's
  # descriptions
  def get_descriptions
    # Retrieves a dataset from the database
    dataset = Description.first(id: description)
    dataset.description
  end

  def get_privileges
    Privilege.new.from_id(privilege)
  end

  def get_titles
    Title.new.from_id(title)
  end

  def get_industry_sectors
    Industry_sector.new.from_id(industry_sector)
  end

  def load(params)
    self.first_name = params.fetch("first_name", "").strip
    self.surname = params.fetch("surname", "").strip
    self.email = params.fetch("email", "").strip
    self.password = params.fetch("password", "").strip
    self.privilege = Privilege.new.from_name(params.fetch("privilege", "").strip)
    self.has_mentee = 0
    self.has_mentor = 0
    self.suspend = 0
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
