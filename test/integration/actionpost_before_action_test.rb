require 'test_helper'

class ActionpostBeforeActionTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @other = users(:mochi)
    @actionpost = @other.actionposts.create(title: "actionpost", highlight: "actionpost", action: "actionpost")
  end

  # before_action :logged_in_user?
  test "redirect to root_path with user not log in" do
    get edit_actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log in")
  end

  # before_action :correct_user?
  test "redirect to root_path when destroy wrong actionpost" do
    log_in_as_test_user(@user)
    assert_no_difference 'Actionpost.count' do
      delete actionpost_path(@actionpost)
    end
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("")
  end

end
