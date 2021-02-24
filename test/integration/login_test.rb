require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
  end

  test "render new with invaild information" do
    get login_path
    assert_response :success
    post login_path, params: {session: {account_id: "", 
                                        password: "foo"}}
    assert_response :success
    assert_match "Log In", @response.body
  end

  test "redirect to users/show with vaild information and followed by logout" do
    get login_path
    assert_response :success
    post login_path, params: {session: {account_id: @user.account_id, 
                                        password: "password"}}
    assert_response :redirect
    follow_redirect!
    assert_match @user.username, @response.body
    # ログアウトのテスト
    delete logout_path
    assert_response :redirect
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    # 2回目のログアウト（バグ修正）
    delete logout_path
    assert_response :redirect
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with remember 1 and followed by login with remmeber 0" do
    log_in_as_test_user(@user)
    assert_not_empty cookies[:remember_token]
    # 一度ログアウト
    delete logout_path
    log_in_as_test_user(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end

end

