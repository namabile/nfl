# == Schema Information
#
# Table name: events
#
#  id                     :integer         not null, primary key
#  event_id               :integer
#  name                   :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  state_id               :integer
#  venue                  :string(255)
#  venue_id               :integer
#  date                   :datetime
#  map_url                :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  grandchild_category_id :integer
#  team_id                :integer
#

class Event < ActiveRecord::Base
	belongs_to :team
	attr_accessible :event_id, :name, :city, :state, :state_id, :venue, :venue_id, :date, :map_url,
		:grandchild_category_id, :team_id
	@client = Savon::Client.new("http://tnwebservices-test.ticketnetwork.com/tnwebservice/v3.0/WSDL/tnwebservice.xml")

	def self.find_by_slug(slug)
		Event.get_team_name(slug)
		@events = Event.find(
			:all, 
			:conditions => ["events.name like ? and date >= ?", "%#{@team_name}%", Time.now], 
			:order => "date")
	end

	def self.get_team_name(slug)
		@team_name = slug.chomp("-Tickets").gsub("-"," ")
	end

	def self.get_events
		response = @client.request :v3, :get_events,
			body: { 
				"websiteConfigID" => 10697, 
				"grandchildCategoryID" => 16 
			}
		if response.success?
			data = response.to_hash[:get_events_response][:get_events_result]
			data[:event].each do |event|
				item = Event.new
				item.event_id = event[:id]
				item.name = event[:name]
				item.city = event[:city]
				item.state = event[:state_province]
				item.state_id = event[:state_province_id]
				item.venue = event[:venue]
				item.venue_id = event[:venue_id]
				item.date = event[:date]
				item.map_url = event[:map_url]
				item.grandchild_category_id = event[:grandchild_category_id]
				item.save
			end
		end
	end	

	def self.get_performers
		response = @client.request :v3, :get_event_performers,
			body: { 
				"websiteConfigID" => 10697, 
			}
		if response.success?
			data = response.to_hash[:get_event_performers_response][:get_event_performers_result]
			data[:event_performer].each do |performer|
				item = Event.where(:event_id => performer[:event_id])
				item.first.update_attribute :team_id, performer[:performer_id] unless item.empty?
			end
		end
	end
end
