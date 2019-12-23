module Mybookings
  class AdobeConnectMeetingRoom < ApplicationRecord
    belongs_to :user, class_name: 'User'

    delegate :email, to: :user, prefix: true

    def self.for_user user
      where(user: user)
    end

    # TODO: Refactor pending to include url in database instead of making an API call
    def url
      meeting = AdobeConnect::Meeting.find_by_id(uuid)
      return nil unless meeting
      "#{AdobeConnect::Service.new.domain}#{meeting.url_path}"
    end
  end
end
