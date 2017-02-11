module MybookingsAdobeConnect
  class Event < Mybookings::Event
    belongs_to :booking, class_name: 'MybookingsAdobeConnect::Booking'

    delegate :adobe_connect_participants, to: :booking, prefix: true

    def cancel!
      super
    end

    def start!
      MeetingRoomService.new(meeting_room_service_params).add_host!
      send_event_started_notification_to_host

      MeetingRoomService.new(meeting_room_service_params).add_participants!
      send_event_started_notification_to_participants

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

    def send_event_started_notification_to_host
      params = { name: booking.adobe_connect_meeting_room.name, url: booking.adobe_connect_meeting_room.url }
      NotificationsMailer.adobe_connect_event_started(params, self.booking.user_email).deliver_now!
    end

    def send_event_started_notification_to_participants
      params = { name: booking.adobe_connect_meeting_room.name, url: booking.adobe_connect_meeting_room.url }
      self.booking_adobe_connect_participants.split(',').each do |email|
        NotificationsMailer.adobe_connect_event_started(params, email).deliver_now!
      end
    end
  end
end
