require 'test_helper'

class BookUserTest < ActiveSupport::TestCase
  test 'valid fixture' do
    assert book_users.map(&:valid?).all?
  end
end
