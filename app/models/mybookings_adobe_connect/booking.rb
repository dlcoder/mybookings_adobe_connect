module MybookingsAdobeConnect
  class Booking < Mybookings::Booking
    has_many :events, class_name: 'MybookingsAdobeConnect::Event'
    belongs_to :adobe_connect_meeting_room, class_name: 'MybookingsAdobeConnect::MeetingRoom', foreign_key: :adobe_connect_meeting_room_id

    validates :adobe_connect_meeting_room_id, presence: true
    validate :adobe_connect_participants_email_list

    def confirm!
      super
    end

    def cancel!
      super
    end

    def prepare!
      UserService.new({ user: user }).prepare!
      MeetingRoomService.new({ meeting_room: adobe_connect_meeting_room }).prepare!
      super
    end

    private

    def adobe_connect_participants_email_list
      return unless adobe_connect_participants.present?

      adobe_connect_participants.split(',').each do |email|
        # If the email is right
        next if /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.match(email)

        # If one email is not valid
        errors.add(:adobe_connect_participants, I18n.t('errors.invalid_email_list'))
        return
      end
    end
  end
end
