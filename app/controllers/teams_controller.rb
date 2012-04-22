class TeamsController < ApplicationController
	def show_events
		@events = Event.find_by_slug(params[:slug])
		@team_name = Event.get_team_name(params[:slug])
	end
end
