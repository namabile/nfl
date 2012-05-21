# == Schema Information
#
# Table name: teams
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  team_id                :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  grandchild_category_id :integer
#
class Team < ActiveRecord::Base
	has_many :events

	@client = Savon::Client.new("http://tnwebservices.ticketnetwork.com/tnwebservice/v3.2/WSDL/tnwebservicestringinputs.xml")

	def self.get_teams
		response = @client.request :v3, :get_performer_by_category,
			body: { 
				"websiteConfigID" => 10697, 
				"parentCategoryID" => 1, 
				"childCategoryID" => 63, 
				"grandchildCategoryID" => 16
			}
		if response.success?
			columns = [:name, :team_id, :grandchild_category_id]
			values = []
			data = response.to_hash[:get_performer_by_category_response][:get_performer_by_category_result]
			data[:performer].each do |performer|
				values.push([
					performer[:description],
					performer[:id],
					performer[:category][:grandchild_category_id]
				])
			end
			Team.import columns, values, :validate => true
		end
	end		

	def self.get_teams_qa
		response = @client.request :v3, :get_performer_by_category,
			body: { 
				"websiteConfigID" => 10697, 
				"parentCategoryID" => 1, 
				"childCategoryID" => 63, 
				"grandchildCategoryID" => 16
			}		
		return {:request => @client.http.to_json, :response => response.to_json}
	end

end
