module Mybookings
  class AdobeConnectNotificationsMailer < ApplicationMailer
    def adobe_connect_event_started params, email
      @name = params[:name]
      @url = params[:url]

      app_name = t('mybookings.app_name')
      notification_subject = t('mybookings.adobe_connect_notifications_mailer.adobe_connect_event_started.subject', meeting_room_name: params[:name])

      mail(to: email, subject: "[#{app_name}] #{notification_subject}")
    end
  end
end
