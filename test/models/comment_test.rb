require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'valid fixture' do
    assert comments.map(&:valid?).all?
  end
end
