if Rails.env.production?
	require "rubygems"
	require "rufus/scheduler"

	scheduler = Rufus::Scheduler.start_new

	scheduler.cron '0 0 * * *', :allow_overlapping => false, :blocking => true, :tags => "refresh events"  do
		Event.refresh_events
	end

	scheduler.cron '15 0 * * *', :allow_overlapping => false, :blocking => true, :tags => "update visits"  do
		Team.get_teams
	end
end