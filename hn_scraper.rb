
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'byebug'
require_relative 'post'
require_relative 'comment'
require_relative 'colors'

class BadUrlError < Exception; end
class BadPostError < NoMethodError; end


unless ARGV[0]  =~ /https:\/\/news\.ycombinator\.com\/item\?id=\d.*/
  raise BadUrlError , red("This application only accepts url generated in format - https://news.ycombinator.com/item?id=99999")
end

page = Nokogiri::HTML(open(ARGV[0]))

if  page.at('title').nil?
  raise BadPostError, red("There is no post present with that id on ycombinator.com website please check your url and try again")
end



#adds all comment objects to post
 def add_to_post(post, all_comments)
  all_comments.each do |comment|
       post.add_comments(comment)
  end
end

def print_nicely(post)
  puts ""
  puts green("Post ID : #{post.item_id}")
  puts blue("Post Title : #{post.title }")
  puts yellow("Number of comments : #{post.comments.length}")

end

#create a new post
post = Post.new(Post.extract_title(page), ARGV[0], Post.extract_points(page), Post.extract_item_id(page))

#add all comments to the post
all_comments = Comment.build_the_comments_array(Comment.extract_author(page), Comment.extract_date(page), Comment.extract_text(page))
add_to_post(post, all_comments)

print_nicely(post)


