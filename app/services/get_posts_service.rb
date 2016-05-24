class GetPostsService
  LIMIT = 100

  def initialize(token, current_group_id)
    @graph = Koala::Facebook::API.new(token)
    @current_group_id = current_group_id
  end

  def get_new_posts
    group = create_new_or_get_group(@current_group_id)

    if group
      if group.posts.count == 0
        since = (Time.now - 5.day).to_i
      else
        since = group.posts.sorted_by_past.first.created_time.to_i
      end

      posts =  @graph.get_object("#{group.group_id}/feed?fields=id,created_time,attachments{media,subattachments},from,message&since=#{since}&limit=#{LIMIT}")

      if posts
        parse_posts_data(posts, group.id)
      end
    end
  end

  private

  def create_new_or_get_group(id)
    group = Group.find_by(group_id: id)
    unless group
      group_info = @graph.get_object(id)
      group = Group.create( group_id: id,
                            name:  group_info['name'] )
    end
    group
  end

  def parse_posts_data(data, parent_id)
    data.each do |post|
      unless Post.find_by(post_id: post['id'])
        new_post = Post.new(group_id: parent_id,
                            author: post['from']['name'],
                            message: post['message'],
                            post_id: post['id'],
                            created_time: post['created_time'])
        if new_post.save && post['attachments']
          get_attachment(new_post, post)
        end
      end
    end

    next_page = data.next_page
    parse_posts_data(next_page ,parent_id) if next_page
  end

  def get_attachment(post, data)
    attachment = data['attachments']['data']
    if attachment[0]['subattachments']
      attachment[0]['subattachments']['data'].each do |subattachments|
        post.contents.create(remote_media_url: subattachments['media']['image']['src'], media_type: 'image')
      end
    elsif attachment
      post.contents.create(remote_media_url: attachment[0]['media']['image']['src'], media_type: 'image')
    end
  end
end