module Mybookings
  class AdobeConnectBooking < Booking
    has_many :events, class_name: 'Event', foreign_key: :booking_id
    belongs_to :adobe_connect_meeting_room, class_name: 'AdobeConnectMeetingRoom', foreign_key: :adobe_connect_meeting_room_id

    validates :adobe_connect_meeting_room_id, :adobe_connect_meeting_privacy, presence: true
    validates :adobe_connect_participants, email_list: true

    enum adobe_connect_meeting_privacy: [:opened, :semiopened, :closed]

    delegate :name, :uuid, :url, to: :adobe_connect_meeting_room, prefix: true

    serialize :adobe_connect_participants, Array

    def confirm!
      super
    end

    def cancel!
      super
    end

    def prepare!
      PrepareAdobeConnectUsersService.new(self).execute
      PrepareAdobeConnectMeetingService.new(self).execute
      SendInvitationsService.new(self).execute

      super
    end

    def to_partial_path
      'bookings/booking'
    end

    def set_adobe_connect_meeting_room_uuid uuid
      adobe_connect_meeting_room.update_attribute(:uuid, uuid)
    end
  end
end
