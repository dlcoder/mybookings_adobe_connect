module MybookingsAdobeConnect
  class MeetingRoom < ActiveRecord::Base
    belongs_to :user, class_name: 'Mybookings::User'

    delegate :email, to: :user, prefix: true

    def self.for_user user
      where(user: user)
    end

    def url
      MeetingRoomService.new({ meeting_room: self }).url
    end
  end
end
