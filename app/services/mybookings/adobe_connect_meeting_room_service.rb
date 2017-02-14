module Mybookings
  class AdobeConnectMeetingRoomService
    def initialize params
      @booking = params[:booking]
      @meeting_room = params[:meeting_room]
    end

    def prepare!
      return if @meeting_room.uuid
      create_meeting_room
    end

    def add_host!
      get_adobe_connect_meeting_by_uuid.add_host(get_adobe_connect_user_by_email.id)
    end

    def remove_host!
      get_adobe_connect_meeting_by_uuid.remove_user(get_adobe_connect_user_by_email.id)
    end

    def add_presenter!
      get_adobe_connect_meeting_by_uuid.add_presenter(get_adobe_connect_user_by_email.id)
    end

    def remove_presenter!
      get_adobe_connect_meeting_by_uuid.remove_user(get_adobe_connect_user_by_email.id)
    end

    def add_participants!
      adobe_connect_meeting = get_adobe_connect_meeting_by_uuid

      @booking.adobe_connect_participants.each do |email|
        adobe_connect_user = AdobeConnectUserService.new({ user: @meeting_room.user }).create_user_if_not_exists(email)
        adobe_connect_meeting.add_participant(adobe_connect_user.id)
      end
    end

    def remove_participants!
      adobe_connect_meeting = get_adobe_connect_meeting_by_uuid

      @booking.adobe_connect_participants.each do |email|
        adobe_connect_user = get_adobe_connect_user_by_email(email)
        adobe_connect_meeting.remove_user(adobe_connect_user.id)
      end
    end

    def url
      "#{AdobeConnectApiInstanceService::get_connection.domain}#{get_adobe_connect_meeting_by_uuid.url_path}"
    end

    private

    def create_meeting_room
      adobe_connect_folder_id = AdobeConnect::MeetingFolder.my_meetings_folder_id(AdobeConnectApiInstanceService::get_connection)

      adobe_connect_meeting = AdobeConnect::Meeting.new({ name: @meeting_room.name, folder_id: adobe_connect_folder_id }, AdobeConnectApiInstanceService::get_connection)
      adobe_connect_meeting.save
      adobe_connect_meeting.private!

      @meeting_room.update_attribute(:uuid, adobe_connect_meeting.id)
    end

    def get_adobe_connect_meeting_by_uuid uuid=@meeting_room.uuid
      AdobeConnect::Meeting.find_by_id(uuid, AdobeConnectApiInstanceService::get_connection)
    end

    def get_adobe_connect_user_by_email email=@meeting_room.user_email
      AdobeConnect::User.find({ email: email }, AdobeConnectApiInstanceService::get_connection)
    end
  end
end
