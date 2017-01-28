class CreateMybookingsAdobeConnectBaseSchema < ActiveRecord::Migration
  def change
    add_column :mybookings_bookings, :adobe_connect_participants, :text
    add_column :mybookings_bookings, :adobe_connect_meeting_room_id, :integer

    create_table :mybookings_adobe_connect_meeting_rooms do |t|
      t.string :uuid
      t.string :name
    end
  end
end
