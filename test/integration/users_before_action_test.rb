require 'test_helper'

class UsersBeforeActionTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @other = users(:mochi)
  end

  # before_action :logged_in_user?
  test "show redirect to root_path with user not log in" do
    # showに不正アクセス
    get user_path(@other)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "edit redirect to root_path with user not log in" do
    # editに不正アクセス
    get edit_user_path(@other)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "udpate redirect to root_path with user not log in" do
    # updateに不正アクセス
    patch user_path(@other), params: {user: {account_id: @user.account_id, 
                                             username: @user.username, 
                                              email: @user.email}}
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  # before_action :correct_user?
  test "redirect to root_path with wrong user" do
    log_in_as_test_user(@user)
    # showに不正アクセス
    get user_path(@other)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
    # editに不正アクセス
    get edit_user_path(@other)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
    # updateに不正アクセス
    patch user_path(@other), params: {user: {account_id: @user.account_id, 
                                             username: @user.username, 
                                             email: @user.email}}
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
  end
end
