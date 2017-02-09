module MybookingsAdobeConnect
  class Event < Mybookings::Event
    belongs_to :booking, class_name: 'MybookingsAdobeConnect::Booking'

    def cancel!
      super
    end

    def start!
      MeetingRoomService.new(meeting_room_service_params).add_host!
      MeetingRoomService.new(meeting_room_service_params).add_participants!
      super
    end

    def end!
      MeetingRoomService.new(meeting_room_service_params).remove_participants!
      MeetingRoomService.new(meeting_room_service_params).remove_host!
      super
    end

    private

    def meeting_room_service_params
      { booking: booking, meeting_room: booking.adobe_connect_meeting_room }
    end
  end
end
