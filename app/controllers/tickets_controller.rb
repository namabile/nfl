class TicketsController < ApplicationController
	caches_page :show_tickets, :expires_in => 5.minutes
	def show_tickets
		client = Savon::Client.new("http://tnwebservices-test.ticketnetwork.com/tnwebservice/v3.0/WSDL/tnwebservice.xml")
		event_id = params[:event_id]
		response = client.request :v3, :get_tickets,
			body: { 
				"websiteConfigID" => 10697, 
				"eventID" => event_id,
				"numberOfRecords" => 10
			}
		@tickets = response.to_hash[:get_tickets_response][:get_tickets_result]
		@event = Event.find_by_event_id(event_id)
		@prices = []
		@tickets[:ticket_group].each do |ticket|
			@prices.push ticket[:actual_price].to_i
		end
		@min_price = @prices.min
		@max_price = @prices.max
	end
	def get_tickets_qa
		client = Savon::Client.new("http://tnwebservices-test.ticketnetwork.com/tnwebservice/v3.0/WSDL/tnwebservice.xml")
		event_id = params[:event_id]
		response = client.request :v3, :get_tickets,
			body: { 
				"websiteConfigID" => 10697, 
				"eventID" => event_id,
				"numberOfRecords" => 10
			}
		@response = response.to_json
		@request = client.http.to_json		
	end
end
