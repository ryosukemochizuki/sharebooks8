require 'test_helper'

class ActionpostsSaveTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    # @actionpost = actionposts(:one)
    @actionpost = @user.actionposts.create(title: "actionpost", highlight: "actionpost", action: "actionpost")
  end

  test "render actionposts when saving with invalid information" do
    log_in_as_test_user(@user)
    get root_path
    post actionposts_path, params: {actionpost: {title: "", 
                                                highlight: "", 
                                                action: ""}}
    assert_response :success
  end

  test "redirect to actionposts/show when saving with valid information and followed by destroy" do
    log_in_as_test_user(@user)
    get root_path
    post actionposts_path, params: {actionpost: {title: "actionpost", 
                                                highlight: "actionpost", 
                                                action: "actionpost"}}
    assert_response :redirect
    follow_redirect!
    assert_match "actionpost", @response.body
    # 削除
    delete actionpost_path(@actionpost)
    assert_response :redirect
    follow_redirect!
    assert_match "The action was deleted.", flash[:success]
    assert_select 'title', full_title("All actions")

  end
  
end
