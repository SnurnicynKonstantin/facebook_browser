class PostsController < ApplicationController
  def index
    group = Group.find_by(group_id: ENV['current_group_id'])

    @title = group.name
    @posts = group.posts.sorted_by_past.paginate(page: params[:page], per_page: 10).includes(:subattachments)
  end
end