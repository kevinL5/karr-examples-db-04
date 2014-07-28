require 'rake'

require_relative 'config/application'

desc 'create the database'
task 'db:create' do
  puts "Creating #{DB_PATH}..."
  touch DB_PATH
end

desc 'drop the database'
task 'db:drop' do
  puts "Deleting #{DB_PATH}..."
  rm_f DB_PATH
end

desc 'migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)'
task 'db:migrate' do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV['VERBOSE'] ? ENV['VERBOSE'] == 'true' : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV['VERSION'] ? ENV['VERSION'].to_i : nil) do |migration|
    ENV['SCOPE'].blank? || (ENV['SCOPE'] == migration.scope)
  end
end

desc 'populate the database with sample data'
task 'db:seed' do
  require APP_ROOT.join('db', 'seeds.rb')
end

desc 'retrieves the current schema version number'
task 'db:version' do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end
