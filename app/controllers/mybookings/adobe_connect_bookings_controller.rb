module Mybookings
  class AdobeConnectBookingsController < BookingsController
    before_action :load_meeting_room_names, only: [:new, :create]
    before_action :preprocess_params, only: [:create]

    def new
      super
    end

    def create
      super
    end

    private

    def load_meeting_room_names
      @meeting_rooms_names = MybookingsAdobeConnect::MeetingRoom.for_user(current_user).map { |meeting_room| meeting_room.name }
    end

    def preprocess_params
      return unless params[:booking][:adobe_connect_meeting_room_id].present?

      meeting_room = MybookingsAdobeConnect::MeetingRoom.find_by(
        user: current_user,
        name: params[:booking][:adobe_connect_meeting_room_id]
      )

      unless meeting_room
        meeting_room = MybookingsAdobeConnect::MeetingRoom.create!(
          user: current_user,
          name: params[:booking][:adobe_connect_meeting_room_id]
        )
      end

      params[:booking][:adobe_connect_meeting_room_id] = meeting_room.id
    end
  end
end
