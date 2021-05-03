class Title < Sequel::Model
  def load(title)
    self.title = title
  end

  def from_name(title)
    record = Title.first(title: title)
    record.id
  end

  def from_id(id)
    record = Title.first(id: id)
    record.title
  end
end
