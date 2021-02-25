require 'test_helper'

class UsersBeforeActionTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @other = users(:mochi)
  end

  test "redirect to root_path with user not log in" do
    get edit_user_path(@user)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log In")
  end

  test "redirect to root_path with wrong user" do
    log_in_as_test_user(@user)
    get edit_user_path(@other)
    assert_response :redirect
    follow_redirect!
    assert_match "Create new Action", @response.body
  end
end
