require_relative 'config/application'

puts '-- presence'
festival = Festival.new
puts festival.valid?
# => false
p festival.errors.messages
# => {:name=>["can't be blank"], :price_per_day=>["can't be blank", ...]}
p festival.errors[:name]
# => "can't be blank"
puts '-'*50

puts '-- uniqueness'
Genre.create(name: 'rock')
genre = Genre.create(name: 'rock')
puts genre.valid?
# => false
p genre.errors.messages
# => {:name=>["has already been taken"]}
puts '-'*50

puts '-- inclusion'
stage   = Stage.new(name: 'Main')
artist  = Artist.new(name: 'Arcade Fire', day: 'lundi', hour: '9pm', stage: stage)
puts artist.valid?
# => false
p artist.errors.messages
# => {:day=>["is not included in the list"]}
puts '-'*50

puts '-- length'
festival  = Festival.new(name: 'Primavera Sound', price_per_day: 145)
organizer = Organizer.new(
  festival:               festival,
  name:                   'Bob',
  email:                  'bob@example.com',
  password:               'pass',
  password_confirmation:  'pass'
)
puts organizer.valid?
# => false
p organizer.errors.messages
# => {:password=>["is too short (minimum is 6 characters)"]}
puts '-'*50

puts '-- numericality'
festival = Festival.new(name: 'Primavera Sound', price_per_day: 'one hundred euros')
puts festival.valid?
# => false
p festival.errors.messages
# => {:price_per_day=>["is not a number"]}
festival.price_per_day = 5
puts festival.valid?
# => false
p festival.errors.messages
# => {:price_per_day=>["must be greater than 10"]}
puts '-'*50

puts '-- format'
festival  = Festival.new(name: 'Primavera Sound', price_per_day: 145)
organizer = Organizer.new(
  festival:               festival,
  name:                   'Bob',
  email:                  'invalid-mail.com',
  password:               'secret_password',
  password_confirmation:  'secret_password'
)
puts organizer.valid?
# => false
p organizer.errors.messages
# => {:email=>["is invalid"]}
puts '-'*50

puts '-- confirmation'
festival  = Festival.new(name: 'Primavera Sound', price_per_day: 145)
organizer = Organizer.new(
  festival:               festival,
  name:                   'Bob',
  email:                  'bob@example.com',
  password:               'secret_password',
  password_confirmation:  'invalid_confirmation'
)
puts organizer.valid?
# => false
p organizer.errors.messages
# => {:password_confirmation=>["doesn't match Password"]}
puts '-'*50

## Removing created models
Genre.delete_all
