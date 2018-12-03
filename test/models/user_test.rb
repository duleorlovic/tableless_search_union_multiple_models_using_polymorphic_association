require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid fixture' do
    assert users.map(&:valid?).all?
  end
end
