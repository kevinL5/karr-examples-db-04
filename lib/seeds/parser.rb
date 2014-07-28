module Seeds
  class Parser
    def initialize(data_url, data_origin)
      @data_url       = data_url
      @data_origin    = data_origin
      @html_document  = fetch_html_document
    end

    def search_line_up(days)
      days.reduce({}) do |artists_per_day, day|
        artists_per_day[day] = search_line_up_by_day(day)

        artists_per_day
      end
    end

    def search_stage_names
      @html_document.search('#deskprog .programDates').map(&:inner_text)
    end

  private

    def fetch_html_document
      line_up_file  = nil

      if @data_origin == 'website'
        line_up_file = open(@data_url)
      else
        line_up_file = File.open(File.join(__dir__, '../../db/lineup.html'))
      end

      Nokogiri::HTML(line_up_file)
    end

    def search_line_up_by_day(day)
      artists_per_stage = @html_document.search("#deskprog .#{day} .blockProg")

      artists_per_stage.map do |stage_artists|
        hours = stage_artists.search('.dateProg').map(&:inner_text)
        names = stage_artists.search('.artistNameProg').map(&:inner_text)

        hours.zip(names).to_h
      end
    end
  end
end
