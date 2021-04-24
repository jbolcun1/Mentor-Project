class Privilege < Sequel::Model

  def load(priv)
    self.privilege = priv
  end

  def from_name(priv)
    record = Privilege.first(privilege: priv)
    record.id
  end

  def from_id(id)
    record = Privilege.first(id: id)
    record.privilege
  end
end

