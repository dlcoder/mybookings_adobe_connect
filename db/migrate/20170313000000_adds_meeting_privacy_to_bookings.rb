class AddsMeetingPrivacyToBookings < ActiveRecord::Migration[4.2]
  def change
    add_column :mybookings_bookings, :adobe_connect_meeting_privacy, :integer, default: 0
  end
end
