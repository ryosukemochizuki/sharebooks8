require 'test_helper'

class ActionpostBeforeActionTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @other = users(:mochi)
    @actionpost = @user.actionposts.create(title: "actionpost", highlight: "actionpost", action: "actionpost")
  end

  test "redirect to root_path with user not log in" do
    get edit_actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("Log In")
  end

end
