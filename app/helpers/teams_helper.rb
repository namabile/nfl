module TeamsHelper
	def event_link(event_name, event_id, event_date, button='')
		team_slug = "#{@team_name.gsub(" ","-")}-Tickets"
		event_date = event_date.strftime("%m-%d-%y").gsub(" ", "-")
		event_slug = event_name.gsub(".","").gsub(" ", "-") + "-" + event_date + "/#{event_id}"
		url = "#{team_slug}/#{event_slug}"
		params = {:event_id => event_id}
		if button.blank? 
			link_to "#{event_name}", url
		else
			link_to "See Tickets", url, class: "btn btn-primary"
		end
	end
end
