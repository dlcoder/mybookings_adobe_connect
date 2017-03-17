module Mybookings
  class AdobeConnectInvitation < ActiveRecord::Base
    belongs_to :booking, class_name: 'AdobeConnectBooking'

    validates :email, email: true
  end
end
