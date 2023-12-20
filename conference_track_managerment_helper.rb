module ConferenceTrackManagementHelper
  LIGHTNING = {
    'lightning' => '5min'
  }.freeze

  MAX_MINUTES_PER_DAY = 420
  MORNING_START = 9
  AFTERNOON_START = 13

  def parse_talks(file_name)
    file_content = File.read(file_name)

    file_content.lines.map do |line|
      parts    = line.strip.match(/^(.+) (\d+min|lightning)$/)
      title    = parts[1]
      duration = LIGHTNING[parts[2]] || parts[2]

      { title: title, duration: duration.to_i }
    end
  end

  def sort_by_duration(talks)
    talks.sort_by { |talk| -talk[:duration] }
  end

  def calculate_number_of_needed_tracks(talks)
    total_talks_duration = talks.sum { |talk| talk[:duration] }
    (total_talks_duration.to_f / MAX_MINUTES_PER_DAY).ceil
  end

  def calculate_total_duration(session, talk)
    session.sum { |t| t[:duration] } + talk[:duration]
  end

  def print_schedule(conference)
    conference.each_with_index do |sessions, index|
      morning_start = Time.new(2000, 1, 1, MORNING_START, 0, 0)
      afternoon_start = Time.new(2000, 1, 1, AFTERNOON_START, 0, 0)

      puts "**Track #{index + 1}:**\n\n"

      sessions[0].each do |t|
        puts "#{format_time(morning_start)}: #{t[:title]}"
        morning_start += t[:duration] * 60
      end

      puts "\n 12:00PM Lunch \n\n"

      sessions[1].each do |t|
        puts "#{format_time(afternoon_start)}: #{t[:title]}"
        afternoon_start += t[:duration] * 60
      end

      puts "#{format_time(afternoon_start)} Networking Event\n\n"
    end
  end

  def format_time(time)
    time.strftime('%l:%M %p')
  end
end
