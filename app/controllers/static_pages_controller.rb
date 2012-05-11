class StaticPagesController < ApplicationController
  caches_page :home, :expires_in => 5.minutes
  def home
  	@teams = Team.where(:grandchild_category_id => 16)
  end

  def get_events
  	data = Event.get_events_qa
  	@request = data[:request]
  	@response = data[:response]
  end
  
  def get_performers
  	data = Team.get_teams_qa
  	@request = data[:request]
  	@response = data[:response]
  end
end
