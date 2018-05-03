module Mybookings
  class PrepareAdobeConnectMeetingService
    def initialize booking
      @booking = booking
    end

    def execute
      meeting = find_meeting_or_create
      @booking.set_adobe_connect_meeting_room_uuid(meeting.id)
    end

    private

    def find_meeting_or_create
      folder_id = AdobeConnect::MeetingFolder.my_meetings_folder_id

      meeting = AdobeConnect::Meeting.find_within_folder(folder_id, {
        filter_name: real_meeting_room_name
      }).first

      unless meeting
        meeting = AdobeConnect::Meeting.new({
          name: real_meeting_room_name,
          folder_id: folder_id
        })

        meeting.save
        meeting.private!
      end

      meeting
    end

    def real_meeting_room_name
      "#{@booking.user_email} - #{@booking.adobe_connect_meeting_room_name}".truncate(60)
    end

    def adobe_connect_meeting
      AdobeConnect::Meeting.find_by_id(@booking.adobe_connect_meeting_room_uuid)
    end
  end
end
