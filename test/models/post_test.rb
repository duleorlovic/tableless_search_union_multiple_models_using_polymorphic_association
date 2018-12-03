require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'valid fixture' do
    assert posts.map(&:valid?).all?
  end
end
