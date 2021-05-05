class Report < Sequel::Model
  def load(user_id, iden, desc, d_t_m)
    self.user_id = user_id
    self.identifier = iden
    self.description_id = desc
    self.date_time_made = d_t_m
  end

  def get_description
    # Retrieves a dataset from the database
    dataset = Description.first(id: description_id)
    dataset.description
  end

  def get_time
    time = Time.parse(date_time_made)
    time.strftime("%T %m/%d/%Y")
  end
end
