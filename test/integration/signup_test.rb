require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(account_id: "@example_123", username: "example user", email: "user@example.com", password: "Password1", password_confirmation: "Password1")
  end

  test "render new with invaid information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {username: "", 
                                       account_id: "", 
                                       email: "", 
                                       password: "foo", 
                                       password_confirmation: "bar"}}
    end
    assert_response :success
    assert_select "input[type=?]", "submit"
  end

  test "redirect_to user_path with vaild information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: @user.username, 
                                       account_id: @user.account_id, 
                                       email: @user.email, 
                                       password: "Password1", 
                                       password_confirmation: "Password1"}}
    end
    assert_response :redirect
    assert is_logged_in?
    follow_redirect!
    assert_select 'title', full_title("#{@user.account_id}")

  end
end