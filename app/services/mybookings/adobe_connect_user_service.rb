module Mybookings
  class AdobeConnectUserService
    def initialize params
      @user = params[:user]
    end

    def prepare!
      create_user_if_not_exists(@user.email)
    end

    def create_user_if_not_exists email
      adobe_connect_user = AdobeConnect::User.find({ email: email }, AdobeConnectApiInstanceService::get_connection)
      return adobe_connect_user unless adobe_connect_user.nil?

      adobe_connect_user_attrs = {
        'email' => email,
        'username' => email,
        'first_name' => email.split('@').first,
        'last_name' => email.split('@').second,
        'uuid' => SecureRandom.uuid,
        'send_email' => false
      }

      adobe_connect_user = AdobeConnect::User.new(adobe_connect_user_attrs, AdobeConnectApiInstanceService::get_connection)
      adobe_connect_user.save

      adobe_connect_user
    end
  end
end
