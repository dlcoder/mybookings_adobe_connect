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
      folder_id = folder_id_for_user(@booking.user_email)

      meeting = AdobeConnect::Meeting.find_within_folder(folder_id, {
        filter_name: @booking.adobe_connect_meeting_room_name
      }).first

      unless meeting
        meeting = AdobeConnect::Meeting.new({
          name: @booking.adobe_connect_meeting_room_name,
          folder_id: folder_id
        })

        meeting.save
        meeting.private!
      end

      meeting
    end

    def folder_id_for_user email
      AdobeConnect::MeetingFolder.my_meetings_folder_id_by_user_email(email)
    end
  end
end
