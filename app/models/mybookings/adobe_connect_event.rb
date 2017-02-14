module Mybookings
  class AdobeConnectEvent < Event
    belongs_to :booking, class_name: 'AdobeConnectBooking', foreign_key: :booking_id

    delegate :adobe_connect_participants, to: :booking, prefix: true

    def cancel!
      super
    end

    def start!
      AdobeConnectMeetingRoomService.new(meeting_room_service_params).add_host!
      send_event_started_notification_to_host

      AdobeConnectMeetingRoomService.new(meeting_room_service_params).add_participants!
      send_event_started_notification_to_participants

      super
    end

    def end!
      AdobeConnectMeetingRoomService.new(meeting_room_service_params).remove_participants!
      AdobeConnectMeetingRoomService.new(meeting_room_service_params).remove_host!
      super
    end

    def to_partial_path
      'events/event'
    end

    private

    def meeting_room_service_params
      { booking: booking, meeting_room: booking.adobe_connect_meeting_room }
    end

    def send_event_started_notification_to_host
      params = { name: booking.adobe_connect_meeting_room.name, url: booking.adobe_connect_meeting_room.url }
      AdobeConnectNotificationsMailer.event_started(params, self.booking.user_email).deliver_now!
    end

    def send_event_started_notification_to_participants
      params = { name: booking.adobe_connect_meeting_room.name, url: booking.adobe_connect_meeting_room.url }
      self.booking_adobe_connect_participants.each do |email|
        AdobeConnectNotificationsMailer.event_started(params, email).deliver_now!
      end
    end
  end
end
