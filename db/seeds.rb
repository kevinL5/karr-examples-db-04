require_relative '../config/application'
require_relative '../lib/seeds/generator'
require_relative '../lib/seeds/parser'

data_origin = ENV['from'] || 'local file'
data_url    = 'http://www.rockenseine.com/en/artists/line-up/'

puts "Seeding data for Rock en Seine, based on #{data_url}. Let's rock the party!"
puts '-'*50

puts 'Removing data...'
Genre.delete_all
Organizer.delete_all
Festival.delete_all
Stage.delete_all
Artist.delete_all

puts 'Generating genre, organizer and festival...'
generator = Seeds::Generator.new
genre     = generator.create_genre('rock')
organizer = generator.create_organizer
festival  = generator.create_festival('Rock en Seine', 49)

puts "Fetching html document from #{data_origin}..."
days        = %w(vendredi samedi dimanche)
parser      = Seeds::Parser.new(data_url, data_origin)
line_up     = parser.search_line_up(days)
stage_names = parser.search_stage_names

puts 'Importing stages and artists...'
stage_names.each_with_index do |stage_name, index|
  stage = generator.create_stage(stage_name)

  days.each do |day|
    artists = line_up[day][index]

    artists.each do |hour, name|
      generator.create_artist(day, hour, name, stage)
    end
  end
end

puts '-'*50
puts 'Seeding done.'
puts "Stages imported: #{Stage.count}"
puts "Artists imported: #{Artist.count}"
