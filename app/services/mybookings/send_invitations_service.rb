module Mybookings
  class SendInvitationsService
    def initialize booking
      @booking = booking
    end

    def execute
      @booking.adobe_connect_participants.each do |email|
        next if AdobeConnectInvitation.find_by(booking: @booking, email: email)

        invitation = AdobeConnectInvitation.create(booking: @booking, email: email)

        params_events = []
        @booking.events.each do |event|
          params_events.push({
            end_date: event.end_date,
            start_date: event.start_date,
          })
        end

        params = {
          user_email: @booking.user_email,
          name: @booking.adobe_connect_meeting_room_name,
          events: params_events
        }

        AdobeConnectNotificationsMailer.adobe_connect_invited_to_booking(params, email).deliver_now!
      end
    end
  end
end
