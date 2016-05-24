desc 'get new posts from facebook'
task get_posts: :environment do
  service = GetPostsService.new( ENV['access_token'], ENV['current_group_id'] )
  service.get_new_posts
end