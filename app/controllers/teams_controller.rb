class TeamsController < ApplicationController
	caches_page :show_events, :expires_in => 1.day
	def show_events
		@events = Event.find_by_slug(params[:slug])
		@team_name = Event.get_team_name(params[:slug])
	end
end
