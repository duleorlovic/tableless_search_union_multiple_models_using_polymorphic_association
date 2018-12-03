require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'valid fixture' do
    assert books.map(&:valid?).all?
  end
end
