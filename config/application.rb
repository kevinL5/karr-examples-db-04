require 'sqlite3'
require 'active_record'
require 'pathname'
require 'nokogiri'
require 'faker'
require 'open-uri'
require 'yaml'

require_relative '../app/models/artist'
require_relative '../app/models/festival'
require_relative '../app/models/genre'
require_relative '../app/models/organizer'
require_relative '../app/models/stage'

# gets root of current directory
APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))

# loads the yml database config file
DB_CONFIG = YAML::load(IO.read(File.join(File.dirname(__FILE__),'database.yml')))

# gets the path of the database
DB_PATH =  APP_ROOT.join(DB_CONFIG["development"]["database"])

ActiveRecord::Base.establish_connection(DB_CONFIG['development'])
