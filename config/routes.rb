Mybookings::Engine.routes.draw do
  get 'resource_types/:resource_type_id/bookings/new',
    to: 'adobe_connect_bookings#new',
    constraints: lambda { |r| Mybookings::ResourceType.find(r.params[:resource_type_id]).extension.eql?('AdobeConnectExtension') }

  post 'resource_types/:resource_type_id/bookings',
    to: 'adobe_connect_bookings#create',
    constraints: lambda { |r| Mybookings::ResourceType.find(r.params[:resource_type_id]).extension.eql?('AdobeConnectExtension') }
end
