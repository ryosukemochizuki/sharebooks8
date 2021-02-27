require 'test_helper'

class ActionpostBeforeActionTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @other = users(:mochi)
    @actionpost = @other.actionposts.create(title: "actionpost", highlight: "actionpost", action: "actionpost")
  end

  # before_action :logged_in_user?
  test "index redirect to root_path with user not log in" do
    # indexに不正アクセス
    get actionposts_path
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "show redirect to root_path with user not log in" do
    # showに不正アクセス
    get actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "create redirect to root_path with user not log in" do
    # createに不正アクセス
    post actionposts_path, params: {actionpost: {title: @actionpost.title, highlight: @actionpost.highlight, action: @actionpost.action}}
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "edit redirect to root_path with user not log in" do
    # editに不正アクセス
    get edit_actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "udpate redirect to root_path with user not log in" do
    # updateに不正アクセス
    patch actionpost_path(@actionpost), params: {actionpost: {title: @actionpost.title, highlight: @actionpost.highlight, action: @actionpost.action}}
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  test "destroy redirect to root_path with user not log in" do
    # destroyに不正アクセス
    delete actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  # before_action :correct_user?
  test "redirect to root_path when destroy wrong actionpost followed by actionpost/edit" do
    log_in_as_test_user(@user)
    # showに不正アクセス
    get actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
    # editに不正アクセス
    get edit_actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
    # updateに不正アクセス
    patch actionpost_path(@actionpost), params: {actionpost: {title: @actionpost.title, highlight: @actionpost.highlight, action: @actionpost.action}}
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
    # destroyに不正アクセス
    assert_no_difference 'Actionpost.count' do
      delete actionpost_path(@actionpost)
    end
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
  end
  
end
