module Mybookings
  class AdobeConnectEvent < Event
    belongs_to :booking, class_name: 'AdobeConnectBooking', foreign_key: :booking_id, dependent: :destroy

    delegate :adobe_connect_participants,
      :adobe_connect_meeting_room_name,
      :adobe_connect_meeting_room_uuid,
      :adobe_connect_meeting_privacy,
      :adobe_connect_meeting_room_url,
      to: :booking, prefix: true

    def cancel!
      super
    end

    def start!
      StartAdobeConnectMeetingService.new(self).execute

      super
    end

    def end!
      FinishAdobeConnectMeetingService.new(self).execute

      super
    end

    def to_partial_path
      'events/event'
    end
  end
end
