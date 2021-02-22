require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(account_id: "@example_123", username: "example user", email: "user@example.com", password: "Password1", password_confirmation: "Password1")
  end

  test "render new with invaid information" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {username: "", 
                                       account_id: "", 
                                       email: "user@invalid", 
                                       password: "foo", 
                                       password_confirmation: "bar"}}
    end
    assert_response :success
    assert_select "input[type=?]", "submit"
  end

  test "redirect_to user_path with vaild information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: @user.username, 
                                       account_id: @user.account_id, 
                                       email: @user.email, 
                                       password: "Password1", 
                                       password_confirmation: "Password1"}}
    end
    assert_equal "you signed up successfully!", flash[:success]
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match @user.username, @response.body

  end
end