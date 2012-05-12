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

	@client = Savon::Client.new("http://tnwebservices-test.ticketnetwork.com/tnwebservice/v3.0/WSDL/tnwebservice.xml")

	def self.get_teams
		response = @client.request :v3, :get_performer_by_category,
			body: { 
				"websiteConfigID" => 10697, 
				"parentCategoryID" => 1, 
				"childCategoryID" => 63, 
				"grandchildCategoryID" => 16
			}
		if response.success?
			inserts = []
			data = response.to_hash[:get_performer_by_category_response][:get_performer_by_category_result]
			data[:performer].each do |performer|
				name = performer[:description]
				team_id = performer[:id]
				grandchild_category_id = performer[:category][:grandchild_category_id]
				
				inserts.push "('#{name}', #{team_id}, '#{Time.now.utc}', '#{Time.now.utc}', #{grandchild_category_id})"
			end
			#inserts = inserts.join(", ")
			inserts.each do |insert|
				sql = "INSERT INTO teams (name, team_id, created_at, updated_at, grandchild_category_id) VALUES #{insert}"	
				Team.connection.execute(sql)
			end
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
