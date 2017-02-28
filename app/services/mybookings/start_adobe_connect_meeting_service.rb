module Mybookings
  class StartAdobeConnectMeetingService
    def initialize event
      @event = event
    end

    def execute
      set_meeting_host
      set_meeting_participants

      notify_event_started
    end

    private

    def set_meeting_host
      meeting = adobe_connect_meeting
      user = adobe_connect_user(@event.booking_user_email)

      meeting.add_host(user.id)
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
      params = {
        name: @event.booking_adobe_connect_meeting_room_name,
        url: get_meeting_url(adobe_connect_meeting)
      }

      emails = [@event.booking_user_email] + @event.booking_adobe_connect_participants

      emails.each do |email|
        AdobeConnectNotificationsMailer.adobe_connect_event_started(params, email).deliver_now!
      end
    end

    def get_meeting_url meeting
      "#{AdobeConnect::Service.new.domain}#{meeting.url_path}"
    end
  end
end
