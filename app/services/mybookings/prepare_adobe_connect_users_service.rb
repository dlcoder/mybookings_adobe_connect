module Mybookings
  class PrepareAdobeConnectUsersService
    def initialize booking
      @booking = booking
    end

    def execute
      user = find_user_or_create({
        email: @booking.user_email,
        first_name: @booking.user_first_name,
        last_name: @booking.user_last_name
      })

      hosts_group = AdobeConnect::Group.find_by_name('mybookings-hosts')
      hosts_group.add_member(user) if hosts_group

      participants_group = AdobeConnect::Group.find_by_name('mybookings-participants')
      @booking.adobe_connect_participants.map do |email|
        user = find_user_or_create({ email: email })
        participants_group.add_member(user) if participants_group
      end
    end

    private

    def find_user_or_create params
      user = AdobeConnect::User.find({ email: params[:email] })
      return user unless user.nil?

      user = AdobeConnect::User.new(user_attrs(params))
      user.save

      user
    end

    def user_attrs params
      email = params[:email]

      # Adobe connect maximum length for full names is 60 characters.
      first_name = (params[:first_name] || email.split('@').first).truncate(30, omission: '')
      last_name = (params[:last_name] || email.split('@').second).truncate(30, omission: '')

      {
        'email' => email,
        'username' => email,
        'first_name' => first_name,
        'last_name' => last_name,
        'uuid' => SecureRandom.uuid,
        'send_email' => false
      }
    end
  end
end
