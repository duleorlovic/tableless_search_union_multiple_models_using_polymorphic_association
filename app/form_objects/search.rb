class Search
  include ActiveModel::Model
  # input
  attr_accessor :s
  # output
  attr_accessor :results

  def params
    "for Book, User or Comment containing <b>#{s}</b>".html_safe
  end
  def perform
    @results = [Book.first, User.first, Comment.first]
  end
end
