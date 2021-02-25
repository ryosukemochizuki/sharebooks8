require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
  end

  test "render new with invalid information" do
    log_in_as_test_user(@user)
    get edit_user_path(@user)
    patch user_path, params: {user: {account_id: "", 
                                     username: "", 
                                     email: ""}}
    assert_response :success
    assert_select 'title', full_title("Edit")
  end

  test "redirect to show with valid information" do
    log_in_as_test_user(@user)
    get edit_user_path(@user)
    patch user_path, params: {user: {account_id: @user.account_id, 
                                     username: @user.username, 
                                     email: @user.email}}
    assert_response :redirect
    follow_redirect!
    assert_select 'title', full_title("#{@user.account_id}")

  end

end
