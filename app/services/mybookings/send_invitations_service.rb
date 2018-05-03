module Mybookings
  class SendInvitationsService
    def initialize booking
      @booking = booking
    end

    def execute
      @booking.adobe_connect_participants.each do |email|
        next if AdobeConnectInvitation.find_by(booking: @booking, email: email)
        invitation = AdobeConnectInvitation.create(booking: @booking, email: email)
        AdobeConnectInvitationsMailer.to_participant(@booking, email).deliver_now!
      end
    end
  end
end
