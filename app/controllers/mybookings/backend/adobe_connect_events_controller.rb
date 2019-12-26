module Mybookings
  class Backend::AdobeConnectEventsController < Backend::EventsController
    def index
      super
    end

    def delete_confirmation
      super
    end

    def destroy
      super
    end

    def update
      super
    end

    private

    def event_params
      params.require(:adobe_connect_event).permit(:resource_id)
    end

    def load_event
      super
    end

    def load_resource
      super
    end
  end
end
