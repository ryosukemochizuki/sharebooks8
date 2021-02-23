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

  test "redirect to users/show with vaild information" do
    get login_path
    assert_response :success
    post login_path, params: {session: {account_id: @user.account_id, 
                                        password: "password"}}
    assert_response :redirect
    follow_redirect!
    assert_match @user.username, @response.body
  end

end
