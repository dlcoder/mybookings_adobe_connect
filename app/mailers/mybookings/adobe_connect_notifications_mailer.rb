module Mybookings
  class AdobeConnectNotificationsMailer < ApplicationMailer
    def adobe_connect_invited_to_booking params, email
      @params = params
      subject = "[#{app_name}] #{t('mybookings.adobe_connect_notifications_mailer.adobe_connect_invited_to_booking.subject', name: params[:name])}"
      mail(to: email, subject: subject)
    end

    def adobe_connect_event_started params, email
      @params = params
      subject = "[#{app_name}] #{t('mybookings.adobe_connect_notifications_mailer.adobe_connect_event_started.subject', name: params[:name])}"
      mail(to: email, subject: subject)
    end

    private

    def app_name
      t('mybookings.app_name')
    end
  end
end
