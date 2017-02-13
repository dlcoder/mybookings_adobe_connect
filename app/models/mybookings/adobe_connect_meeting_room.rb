module Mybookings
  class AdobeConnectMeetingRoom < ActiveRecord::Base
    belongs_to :user, class_name: 'User'

    delegate :email, to: :user, prefix: true

    def self.for_user user
      where(user: user)
    end

    def url
      AdobeConnectMeetingRoomService.new({ meeting_room: self }).url
    end
  end
end
