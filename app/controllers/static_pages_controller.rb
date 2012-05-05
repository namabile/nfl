class StaticPagesController < ApplicationController
  caches_page :home, :expires_in => 5.minutes
  def home
  	@teams = Team.where(:grandchild_category_id => 16)
  end
end
