class HomeController < ApplicationController
  def index
    if Group.find_by(group_id: ENV['current_group_id']).nil?
      GetPostsService.new( ENV['access_token'], ENV['current_group_id'] ).get_new_posts
    end

    group = Group.find_by(group_id: ENV['current_group_id'])

    @title = group.name
    @posts = group.posts.sorted_by_past.paginate(:page => params[:page], :per_page => 10)
  end
end