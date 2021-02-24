require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:satoshi)
    remember(@user)
  end

  # 失敗
  test "current_user is nil with using cookies when remember_digest is nil or wrong" do
    @user.update_attribute(:remember_digest, nil)
    assert_nil current_user
  end
  # 成功
  test "current_user is @user with using cookies when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end
  
end