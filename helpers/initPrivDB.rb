require "require_all"

ENV["APP_ENV"] = "test"

require_rel "../db/db"
require_rel "../models"

def init_db_priv
  puts "Running privDB Init"
  DB[:users].delete

  dataset = DB[:privileges]
  dataset.delete

  privilege_list = %w[Founder Mentee Mentor Admin]
  privilege_list.each do |priv|
    privilege = Privilege.new
    privilege.load(priv)
    privilege.save_changes
  end
  puts "Finished privDB Init"
end

init_db_priv if $PROGRAM_NAME == __FILE__
