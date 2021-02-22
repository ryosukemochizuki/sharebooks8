require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(account_id: "@example_123", username: "example user", email: "user@example.com", password: "Password1", password_confirmation: "Password1")
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select 'title', full_title("Sign Up")
  end

end
