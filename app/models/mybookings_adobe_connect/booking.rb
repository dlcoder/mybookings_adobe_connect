module MybookingsAdobeConnect
  class Booking < Mybookings::Booking
    belongs_to :adobe_connect_meeting_room, class_name: 'MybookingsAdobeConnect::MeetingRoom', foreign_key: :adobe_connect_meeting_room_id
  end
end
