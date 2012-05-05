class TeamsController < ApplicationController
	caches_page :show_events, :expires_in => 5.minutes
	def show_events
		@events = Event.find_by_slug(params[:slug])
		@team_name = Event.get_team_name(params[:slug])
	end
end
