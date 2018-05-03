module Mybookings
  class AdobeConnectInvitationsMailer < ApplicationMailer
    def to_participant(booking, participant_email)
      @booking = booking

      from = booking.resource_type_notifications_email_from
      from = MYBOOKINGS_CONFIG['default_notifications_email'] if from.blank?

      mail(
        from: from,
        to: participant_email,
        subject: subject(t('mybookings.adobe_connect_invitations_mailer.to_participant.subject', resource_type_name: booking.resource_type_name)),
      )
    end
  end
end
