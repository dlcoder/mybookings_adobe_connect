module Mybookings
  class AdobeConnectBooking < Booking
    has_many :events, class_name: 'Event', foreign_key: :booking_id
    belongs_to :adobe_connect_meeting_room, class_name: 'AdobeConnectMeetingRoom', foreign_key: :adobe_connect_meeting_room_id

    validates :adobe_connect_meeting_room_id, presence: true
    validate :adobe_connect_participants_email_list

    delegate :name, to: :adobe_connect_meeting_room, prefix: true
    delegate :uuid, to: :adobe_connect_meeting_room, prefix: true

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

      super
    end

    def to_partial_path
      'bookings/booking'
    end

    def set_adobe_connect_meeting_room_uuid uuid
      adobe_connect_meeting_room.update_attribute(:uuid, uuid)
    end

    private

    def adobe_connect_participants_email_list
      return unless adobe_connect_participants.present?

      adobe_connect_participants.each do |email|
        # If the email is right
        next if /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.match(email)

        # If one email is not valid
        errors.add(:adobe_connect_participants, I18n.t('errors.invalid_email_list'))
        return
      end
    end
  end
end
