require_relative 'config/application'

def clear_database
  Genre.delete_all
  Organizer.delete_all
  Festival.delete_all
  Stage.delete_all
  Artist.delete_all
end

clear_database

## Models creation
genre = Genre.create(name: 'rock')

festival = Festival.create(
  name:           'Primavera Sound',
  price_per_day:  145
)

festival.genres << genre

organizer = festival.create_organizer(
  name:                   'Bob',
  email:                  'bob@example.com',
  password:               'bobthesponge',
  password_confirmation:  'bobthesponge'
)

stage = festival.stages.create(name: 'Main')

artist = stage.artists.create(
  day:    'samedi',
  hour:   '9pm',
  name:   'Arcade Fire'
)

## Reloading our models
[genre, organizer, festival, stage, artist].each { |model| model.reload }

puts '-- belongs_to'
puts organizer.festival.name
# => Primavera Sound
puts stage.festival.name
# => Primavera Sound
puts artist.stage.name
# => Main
puts '-'*50

puts '-- has_one'
puts festival.organizer.name
# => Bob
puts '-'*50

puts '-- has_many'
p festival.stages.map(&:name)
# => ["Main"]
p stage.artists.map(&:name)
# => ["Arcade Fire"]
puts '-'*50

puts '-- has_and_belongs_to_many'
p festival.genres.map(&:name)
# => ["rock"]
p genre.festivals.map(&:name)
# => ["Primavera Sound"]
puts '-'*50

puts '-- has_many :through'
p festival.artists.map(&:name)
# => ["Arcade Fire"]
puts '-'*50

puts '-- Chaining'
puts artist.stage.festival.name
# => Primavera Sound
puts '-'*50

clear_database
