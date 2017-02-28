module Mybookings
  class PrepareAdobeConnectMeetingService
    def initialize meeting_room
      @meeting_room = meeting_room
    end

    def execute
      meeting = find_meeting_or_create
      @meeting_room.update_attribute(:uuid, meeting.id)
    end

    private

    def find_meeting_or_create
      # TODO: find folder id for user
      folder_id = AdobeConnect::MeetingFolder.my_meetings_folder_id

      meeting = AdobeConnect::Meeting.find_within_folder(folder_id, {
        filter_name: @meeting_room.name
      }).first

      unless meeting
        meeting = AdobeConnect::Meeting.new({
          name: @meeting_room.name,
          folder_id: folder_id
        })

        meeting.save
        meeting.private!
      end

      meeting
    end
  end
end
