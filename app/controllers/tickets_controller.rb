class TicketsController < ApplicationController
	caches_page :show_tickets, :expires_in => 5.minutes
	def show_tickets
		client = Savon::Client.new("http://tnwebservices-test.ticketnetwork.com/tnwebservice/v3.0/WSDL/tnwebservice.xml")
		event_id = params[:event_id]
		response = client.request :v3, :get_tickets,
			body: { 
				"websiteConfigID" => 10697, 
				"eventID" => event_id 
			}
		@tickets = response.to_hash[:get_tickets_response][:get_tickets_result]
		#@tickets = @tickets.sort_by{ |actual_price, price| price }
		@event = Event.find_by_event_id(event_id)
	end
end
