require "require_all"

ENV["APP_ENV"] = "test"

require_rel "../db/db"
require_rel "../models"

def init_db_ind_sec
  puts "Running indSecDB Init"
  DB[:users].delete

  dataset = DB[:industry_sectors]
  dataset.delete

  sectors_list = ["Accountancy, banking and finance", "Business, consulting and management",
                  "Charity and voluntary work", "Creative arts and design", "Energy and utilities",
                  "Engineering and manufacturing", "Environment and agriculture", "Healthcare",
                  "Hospitality and events management", "Information technology", "Law", "Law enforcement and security",
                  "Leisure, sport and tourism", "Marketing, advertising and PR", "Media and internet",
                  "Property and construction", "Public services and administration", "Recruitment and HR", "Retail",
                  "Sales", "Science and pharmaceuticals", "Teacher training and education", "Transport and logistics"]
  sectors_list.each do |sector|
    sector_record = Industry_sector.new
    sector_record.load(sector)
    sector_record.save_changes
  end
  puts "Finished indSecDB Init"
end

init_db_ind_sec if $PROGRAM_NAME == __FILE__
