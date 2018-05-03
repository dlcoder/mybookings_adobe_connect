module Mybookings
  class AdobeConnectRemindersMailer < ApplicationMailer
    def to_participant(event, participant_email)
      @event = event

      from = event.booking_resource_type_notifications_email_from
      from = MYBOOKINGS_CONFIG['default_notifications_email'] if from.blank?

      mail(
        from: from,
        to: participant_email,
        subject: subject(t('mybookings.adobe_connect_reminders_mailer.to_participant.subject', resource_type_name: event.resource_resource_type_name)),
      )
    end
  end
end
