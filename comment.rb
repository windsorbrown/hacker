class Comment

  attr_reader :author, :days, :text

  def initialize(author, days, text)
    @author = author
    @days = days
    @text = text
  end

  class << self

    def extract_author(page)
      authors = []
      page.search('.default').map do |element|
        author = element.at('a:first-child').text
        authors << author
      end
      authors
    end

    def extract_date(page)
      dates = []
      page.search('.age').map do |element|
        date = element.at('a:first-child').text
        dates <<  date
      end
       dates.shift
       dates 
    end

    def extract_text(page)
      comments = []
      page.search('.comment').map do |element|
        text = element.inner_text
        comments <<  text
      end
      comments
    end

    def build_the_comments_array(author, date, comments)
      comments_array = []
      if author.length == date.length && date.length == comments.length
        author.length.times do |x|
            comments_array << Comment.new(author[x], date[x], comments[x])
        end
      else
        #error
      end
      comments_array
    end


  end
end