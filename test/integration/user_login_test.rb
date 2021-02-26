require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
  end

  test "render new with invaild information" do
    get login_path
    post login_path, params: {session: {account_id: "", 
                                        password: "foo"}}
    assert_response :success
    assert_select 'title', full_title("Log in")
  end

  test "redirect to user_path with vaild information and followed by logout (2)" do
    log_in_as_test_user(@user)
    assert_response :redirect
    follow_redirect!
    assert_match @user.username, @response.body
    # ログアウトのテスト
    delete logout_path
    assert_response :redirect
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    # 2回目のログアウト（バグ修正確認）
    delete logout_path
    assert_response :redirect
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with remember_me 1 and followed by login with remmeber_me 0" do
    log_in_as_test_user(@user)
    assert_not_empty cookies[:remember_token]
    # 一度ログアウト
    delete logout_path
    log_in_as_test_user(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

end

