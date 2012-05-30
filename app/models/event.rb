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
	@client = Savon::Client.new("http://tnwebservices.ticketnetwork.com/tnwebservice/v3.2/WSDL/tnwebservicestringinputs.xml")

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
			columns = [:event_id, :name, :city, :state, :state_id, :venue, :venue_id, :date, :map_url, :grandchild_category_id]
			values = []
			data = Hash.from_xml(response.to_xml)
			data["Envelope"]["Body"]["GetEventsResponse"]["GetEventsResult"]["Event"].each do |event|
				values.push([
					event["ID"],
					event["Name"],
					event["City"],
					event["StateProvince"],
					event["StateProvinceID"],
					event["Venue"],
					event["VenueID"],
					event["Date"],
					event["MapURL"],
					event["GrandchildCategoryID"]
				])
			end
			Event.import columns, values, :validate => true
		end
	end

	def self.get_performers
		response = @client.request :v3, :get_event_performers,
			body: { 
				"websiteConfigID" => 10697, 
			}
		if response.success?
			data = response.to_hash[:get_event_performers_response][:get_event_performers_result]
			columns = [:event_id, :team_id]
			values = []
			data[:event_performer].each do |performer|
				values.push([
						performer[:event_id],
						performer[:performer_id]
					])
			end
			ids = Event.find(:all, :select => :event_id).map {|x| x.event_id}
			values = values & 
				item = Event.where(:event_id => performer[:event_id])
				item.first.update_attribute :team_id, performer[:performer_id] unless item.empty?
		end
	end
	def self.get_events_qa
		response = @client.request :v3, :get_events,
		body: { 
			"websiteConfigID" => 10697, 
			"grandchildCategoryID" => 16 
		}
		return {:request => @client.http.to_json, :response => response.to_json }
	end

	def self.refresh_events
		Event.delete_all
		Event.get_events
		Update.post_update("events updated")		
		Event.get_performers
		Update.post_update("performers updated")
	end
end
