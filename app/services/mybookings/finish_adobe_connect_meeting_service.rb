module Mybookings
  class FinishAdobeConnectMeetingService
    def initialize event
      @event = event
    end

    def execute
      remove_meeting_participants
      remove_meeting_host
      set_meeting_as_private
    end

    private

    def remove_meeting_participants
      meeting = adobe_connect_meeting

      @event.booking_adobe_connect_participants.each do |email|
        user = adobe_connect_user(email)
        meeting.remove_user(user.id)
      end
    end

    def remove_meeting_host
      meeting = adobe_connect_meeting
      user = adobe_connect_user(@event.booking_user_email)

      meeting.remove_user(user.id)

      live_admins_group = AdobeConnect::Group.find_by_type('live-admins')
      live_admins_group.remove_member(user)
    end

    def set_meeting_as_private
      meeting = adobe_connect_meeting
      meeting.private!
    end

    def adobe_connect_meeting
      AdobeConnect::Meeting.find_by_id(@event.booking_adobe_connect_meeting_room_uuid)
    end

    def adobe_connect_user email
      AdobeConnect::User.find({ email: email })
    end
  end
end
