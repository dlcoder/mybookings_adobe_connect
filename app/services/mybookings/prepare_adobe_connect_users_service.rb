module Mybookings
  class PrepareAdobeConnectUsersService
    def initialize booking
      @booking = booking
    end

    def execute
      user = find_user_or_create(@booking.user_email)

      @booking.adobe_connect_participants.map do |email|
        find_user_or_create(email)
      end
    end

    private

    def find_user_or_create email
      user = AdobeConnect::User.find({ email: email })
      return user unless user.nil?

      user = AdobeConnect::User.new(user_attrs(email))
      user.save

      user
    end

    def user_attrs email
      {
        'email' => email,
        'username' => email,
        'first_name' => email.split('@').first,
        'last_name' => email.split('@').second,
        'uuid' => SecureRandom.uuid,
        'send_email' => false
      }
    end
  end
end
