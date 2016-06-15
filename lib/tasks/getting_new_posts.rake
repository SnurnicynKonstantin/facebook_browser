desc 'get new posts from facebook'
task get_new_posts: :environment do
  service = FacebookService.new(ENV['access_token'], ENV['current_group_id'] )
  service.get_new_posts
end