class Description < Sequel::Model
  def load(params)
    self.description = params.fetch("description", "").strip
  end
end
