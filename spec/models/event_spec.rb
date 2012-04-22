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

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
