class StaticPagesController < ApplicationController
  def home
  	@teams = Team.where(:grandchild_category_id => 16)
  end
end
