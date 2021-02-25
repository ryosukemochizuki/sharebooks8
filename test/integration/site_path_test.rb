require 'test_helper'

class SiteRootTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:satoshi)
  end
  
  test "root_path links" do
    # ログイン前
    get root_path
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    # ログイン後
    log_in_as_test_user(@user)
    assert_response :redirect
    follow_redirect!
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
