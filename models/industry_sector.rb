class Industry_sector < Sequel::Model
  def load(sector)
    self.sector = sector
  end

  def from_name(sector)
    record = Industry_sector.first(sector: sector)
    record.id
  end

  def from_id(id)
    record = Industry_sector.first(id: id)
    record.sector
  end
end
