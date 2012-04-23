class StaticPagesController < ApplicationController
  caches_page :home, :expires_in => 1.day
  def home
  	@teams = Team.where(:grandchild_category_id => 16)
  end
end
