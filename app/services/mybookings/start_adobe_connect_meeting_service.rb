module Mybookings
  class StartAdobeConnectMeetingService
    def initialize event
      @event = event
    end

    def execute
      set_meeting_privacy
      set_meeting_host
      set_meeting_participants

      notify_event_started
    end

    private

    def set_meeting_privacy
      self.send("set_meeting_privacy_as_#{@event.booking_adobe_connect_meeting_privacy}")
    end

    def set_meeting_privacy_as_closed
      meeting = adobe_connect_meeting
      meeting.private!
    end

    def set_meeting_privacy_as_semiopened
      meeting = adobe_connect_meeting
      meeting.protected!
    end

    def set_meeting_privacy_as_opened
      meeting = adobe_connect_meeting
      meeting.public!
    end

    def set_meeting_host
      meeting = adobe_connect_meeting
      user = adobe_connect_user(@event.booking_user_email)

      meeting.add_host(user.id)

      live_admins_group = AdobeConnect::Group.find_by_type('live-admins')
      live_admins_group.add_member(user)
    end

    def set_meeting_participants
      meeting = adobe_connect_meeting

      @event.booking_adobe_connect_participants.each do |email|
        user = adobe_connect_user(email)
        meeting.add_participant(user.id)
      end
    end

    def adobe_connect_meeting
      AdobeConnect::Meeting.find_by_id(@event.booking_adobe_connect_meeting_room_uuid)
    end

    def adobe_connect_user email
      AdobeConnect::User.find({ email: email })
    end

    def notify_event_started
      @event.booking_adobe_connect_participants.each do |email|
        AdobeConnectRemindersMailer.to_participant(@event, email).deliver_now!
      end
    end
  end
end
