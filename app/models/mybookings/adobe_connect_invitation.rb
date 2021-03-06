module Mybookings
  class AdobeConnectInvitation < ApplicationRecord
    belongs_to :booking, class_name: 'AdobeConnectBooking'

    validates :email, email: true
  end
end
