module TicketsHelper
	def get_checkout_link(event_id,ticket_group_id,price,requested_qty)
		p_id = 5329275
		affiliate_url = "http://www.tkqlhce.com/click-#{p_id}-10843777?url="
		broker_id = 1
		site_number = 3
		qty = requested_qty
		chars = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).join	
		length = chars.length
		i  = 0
		session_id = ''
		while i <= 4 do
			index = rand(length)
			session_id += chars[index]
			i += 1
		end
		tn_url = "https://secure.ticketnetwork.com/checkout/Checkout.aspx?"
		base_url = "brokerid=#{broker_id}&sitenumber=#{site_number}&evtID=#{event_id}&tgid=#{ticket_group_id}&price=#{price}&treq=#{requested_qty}&SessionId=#{session_id}"
		url = "#{affiliate_url + url_encode(tn_url + base_url)}"
		link_to "Add to Cart", url, class: "btn btn-primary add-to-cart", "data-price" => price, "data-session" => session_id
	end
end
