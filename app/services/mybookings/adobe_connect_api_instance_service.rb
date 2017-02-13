module Mybookings
  class AdobeConnectApiInstanceService
    AdobeConnect::Config.declare do
      username Rails.application.secrets.adobeconnect_username
      password Rails.application.secrets.adobeconnect_password
      domain   Rails.application.secrets.adobeconnect_domain
    end

    def self.get_connection
      @@connection ||= AdobeConnect::Service.new
      @@connection.log_in
      @@connection
    end
  end
end
