require 'test_helper'

class SearchResultTest < ActionView::TestCase
  test 'show all models' do
    results = SearchResult.get_all.all
    results_searchable = results.map &:searchable
    assert_includes results_searchable, Book.first
    assert_includes results_searchable, User.first
    assert_includes results_searchable, Post.first
    assert_includes results_searchable, Comment.first
  end

  test 'search texts in models' do
    results = SearchResult.search('kayak')
    results_searchable = results.map &:searchable
    expected = [
      books(:kayak_in_becej),
      comments(:milenko_comment_post),
      posts(:all_about_kayaking),
    ]

    assert_equal_when_sorted expected, results_searchable
  end

  test 'search all models associated by user' do
    results = SearchResult.search('marko')
    results_searchable = results.map &:searchable
    expected = [
      books(:kayak_in_becej),
      books(:water_sports),
      users(:marko_tomicevic),
      posts(:all_about_kayaking),
    ]
    assert_equal_when_sorted expected, results_searchable
  end
end
