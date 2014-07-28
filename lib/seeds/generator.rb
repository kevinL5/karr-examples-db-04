module Seeds
  class Generator
    def initialize
      @festival   = nil
      @genre      = nil
      @organizer  = nil
    end

    def create_artist(day, hour, name, stage)
      Artist.create(
        day:    day,
        hour:   hour,
        name:   name,
        stage:  stage
      )
    end

    def create_genre(name)
      @genre = Genre.create(name: name)
    end

    def create_festival(name, price)
      @festival = Festival.create(
        name:           name,
        price_per_day:  price,
        organizer:      @organizer,
        genres:         [@genre]
      )
    end

    def create_organizer
      password    = Faker::Internet.password
      @organizer  = Organizer.create(
        name:                   Faker::Name.name,
        email:                  Faker::Internet.email,
        password:               password,
        password_confirmation:  password
      )
    end

    def create_stage(name)
      Stage.create(
        name:     name,
        festival: @festival
      )
    end
  end
end
