require 'test_helper'

class ActionpostEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @actionpost = @user.actionposts.create(title: "actionpost", highlight: "actionpost", action: "actionpost")
  end

  test "render edit when updating with invalid information" do
    log_in_as_test_user(@user)
    get edit_actionpost_path(@actionpost)
    patch actionpost_path, params: {actionpost: {title: "", 
                                                 highlight: "", 
                                                 action: ""}}
    assert_response :success
    assert_match "Edit my Action", @response.body
  end

  test "redirect to actionpost/show when updating with valid information" do
    log_in_as_test_user(@user)
    get edit_actionpost_path(@actionpost)
    patch actionpost_path, params: {actionpost: {title: @actionpost.title, 
                                                 highlight: @actionpost.highlight, 
                                                 action: @actionpost.action}}
    assert_response :redirect
    follow_redirect!
    assert_match @actionpost.title, @response.body
  end

end
