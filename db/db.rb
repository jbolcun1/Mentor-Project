require "logger"
require "sequel"

# What mode are we in?
type = ENV.fetch("APP_ENV", "test")

# Find the path to the database file
db_path = File.dirname(__FILE__)
db = "#{db_path}/#{type}.sqlite3"

# Find the path to the log
log_path = "#{File.dirname(__FILE__)}/../log/"
log = "#{log_path}/#{type}.log"

# Create log directory if it does not exist
Dir.mkdir(log_path) unless File.exist?(log_path)

# Set up the Sequel database instance
DB = Sequel.sqlite(db, logger: Logger.new(log))
