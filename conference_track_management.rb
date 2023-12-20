require_relative 'conference_track_managerment_helper'

class ConferenceTrackManagement
  include ConferenceTrackManagementHelper

  TEST_INPUT_FILE = 'test_input.txt'.freeze

  MORNING_SESSION_DURATION = 180
  AFTERMOON_SESSION_DURATION = 240

  def organize_talks
    talks = parse_talks(TEST_INPUT_FILE)
    talks = sort_by_duration(talks)

    number_of_tracks = calculate_number_of_needed_tracks(talks)

    conference        = []
    morning_session   = []
    afternoon_session = []

    # This variable is used to delete the talks already included in the conference.
    temp_talks = talks.dup

    number_of_tracks.times do
      talks.each do |talk|
        if calculate_total_duration(morning_session, talk) <= MORNING_SESSION_DURATION
          morning_session << talk
          temp_talks.delete(talk)
        elsif calculate_total_duration(afternoon_session, talk) <= AFTERMOON_SESSION_DURATION
          afternoon_session << talk
          temp_talks.delete(talk)
        end
      end

      talks = temp_talks.dup

      track = [morning_session, afternoon_session]
      conference << track

      morning_session = []
      afternoon_session = []
    end

    print_schedule(conference) # for testing purposes
  end
end

ConferenceTrackManagement.new.organize_talks
