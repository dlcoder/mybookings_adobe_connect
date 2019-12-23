class CreateMybookingsAdobeConnectInvitations < ActiveRecord::Migration[4.2]
  def change
    create_table :mybookings_adobe_connect_invitations, id: false do |t|
      t.integer :booking_id
      t.string :email
      t.timestamps
    end

    add_index :mybookings_adobe_connect_invitations, :booking_id
    add_index :mybookings_adobe_connect_invitations, :email
  end
end
