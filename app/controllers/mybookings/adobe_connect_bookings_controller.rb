module Mybookings
  class AdobeConnectBookingsController < BookingsController
    before_action :load_meeting_room_names, only: [:new, :edit, :create, :update]
    before_action :preprocess_adobe_connect_meeting_room_id, only: [:create, :update]
    before_action :preprocess_adobe_connect_participants, only: [:create, :update]

    def new
      super
    end

    def edit
      super
    end

    def create
      super
    end

    def update
      super
    end

    def destroy
      super
    end

    private

    def booking_params_for_update
      super.merge(params.require(booking_type.model_name.param_key).permit(:adobe_connect_meeting_room_id, :adobe_connect_participants => []))
    end

    def booking_type
      AdobeConnectBooking
    end

    def load_meeting_room_names
      @meeting_rooms_names = AdobeConnectMeetingRoom.for_user(current_user).map { |meeting_room| meeting_room.name }
    end

    def preprocess_adobe_connect_meeting_room_id
      return unless params[booking_type.model_name.param_key][:adobe_connect_meeting_room_id].present?

      meeting_room = AdobeConnectMeetingRoom.find_by(
        user: current_user,
        name: params[booking_type.model_name.param_key][:adobe_connect_meeting_room_id]
      )

      unless meeting_room
        meeting_room = AdobeConnectMeetingRoom.create!(
          user: current_user,
          name: params[booking_type.model_name.param_key][:adobe_connect_meeting_room_id]
        )
      end

      params[booking_type.model_name.param_key][:adobe_connect_meeting_room_id] = meeting_room.id
    end

    def preprocess_adobe_connect_participants
      emails_list = params[booking_type.model_name.param_key][:adobe_connect_participants]
      emails_list = emails_list.gsub(/\s+/, '').split(',')
      params[booking_type.model_name.param_key][:adobe_connect_participants] = emails_list
    end
  end
end
