class Post

  attr_reader :title, :url , :points, :item_id 

  def initialize(title, url , points, item_id)
    @title = title
    @url = url
    @points = points
    @item_id = item_id
    @comments = []
  end

  def comments
    @comments
  end

  def add_comments(comment)
    @comments << comment
  end

  class << self
  
    def extract_title(page)
      title = page.at('title').inner_text
    end

    def extract_points(page)
      points = page.at('.score').inner_text
    end

    def extract_item_id(page)
      item_id = ARGV[0].slice( /\b\d.*/)
    end

  end

end

