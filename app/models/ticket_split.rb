class TicketSplit < ActiveRecord::Base
	belongs_to :ticket
	@client = Savon::Client.new("http://tnwebservices-test.ticketnetwork.com/tnwebservice/v3.0/WSDL/tnwebservice.xml")

	def self.get_ticket_splits
		Event.all.each do |event|
			@event_id = event.event_id
			response = @client.request :v3, :get_tickets,
				body: { 
					"websiteConfigID" => 10697, 
					"eventID" => @event_id 
				}
			if response.success?
				data = response.to_hash[:get_tickets_response][:get_tickets_result]
				data[:ticket_group].each do |ticket|
					@id = ticket[:id]
					ticket[:valid_splits].to_array.each do |split|
						item = TicketSplit.new
						item.ticket_id = @id
						item.split = split[:int]
						item.row = ticket[:row]
						item.section = ticket[:section]
						item.quantity = ticket[:ticket_quantity]
						item.ticket_type = ticket[:ticket_group_type]
						item.price = ticket[:actual_price]
						item.save
				end
			end
		end
	end	

end
