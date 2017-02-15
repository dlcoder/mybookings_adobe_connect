Mybookings::Engine.routes.draw do
  get 'resource_types/:resource_type_id/bookings/new',
    to: 'adobe_connect_bookings#new',
    constraints: lambda { |r| Mybookings::ResourceType.find(r.params[:resource_type_id]).extension.eql?('AdobeConnectExtension') }

  get 'bookings/:booking_id',
    to: 'adobe_connect_bookings#show',
    constraints: lambda { |r| Mybookings::Booking.find(r.params[:booking_id]).resource_type_extension.eql?('AdobeConnectExtension') }

  post 'resource_types/:resource_type_id/bookings',
    to: 'adobe_connect_bookings#create',
    constraints: lambda { |r| Mybookings::ResourceType.find(r.params[:resource_type_id]).extension.eql?('AdobeConnectExtension') }

  patch 'bookings/:booking_id',
    to: 'adobe_connect_bookings#update',
    constraints: lambda { |r| Mybookings::Booking.find(r.params[:booking_id]).resource_type_extension.eql?('AdobeConnectExtension') }
end
