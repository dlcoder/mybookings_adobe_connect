module Mybookings
  class AdobeConnectMeetingRoom < ActiveRecord::Base
    belongs_to :user, class_name: 'User'

    delegate :email, to: :user, prefix: true

    def self.for_user user
      where(user: user)
    end
  end
end
