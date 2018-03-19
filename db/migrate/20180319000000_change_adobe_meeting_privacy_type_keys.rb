class ChangeAdobeMeetingPrivacyTypeKeys < ActiveRecord::Migration
  def change
    ActiveRecord::Base.record_timestamps = false
    begin
      closed_bookings = Mybookings::AdobeConnectBooking.with_deleted.where(adobe_connect_meeting_privacy: 0).load
      opened_bookings = Mybookings::AdobeConnectBooking.with_deleted.where(adobe_connect_meeting_privacy: 2).load

      closed_bookings.each do |closed_booking|
        closed_booking.adobe_connect_meeting_privacy = 2
        closed_booking.save!(validate: false)
      end
      opened_bookings.each do |opened_booking|
        opened_booking.adobe_connect_meeting_privacy = 0
        opened_booking.save!(validate: false)
      end
    ensure
      ActiveRecord::Base.record_timestamps = true
    end
  end
end
