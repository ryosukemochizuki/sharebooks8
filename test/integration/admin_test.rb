require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:satoshi)
    @other = users(:mochi)
  end

  # 全てのユーザーが表示されているか
  test "admin/users#index" do
    log_in_as_test_user(@user)
    get admin_users_path
    User.all.each do |user|
      assert_select 'td', user.account_id
    end
  end

  # 管理者がユーザーを削除できるか
  test "admin user delete user" do
    log_in_as_test_user(@user)
    get admin_users_path
    assert_difference 'User.count', -1 do
      delete admin_user_path(@other)
    end
    assert_response :redirect
  end

  # before_action :logged_in_user?
  test "index redirect to root_url with non login user" do
    get admin_users_path
    assert_equal "your access is not right, Please log in!", flash[:danger]
    assert_response :redirect
  end

  test "destroy redirect to root_url with non login user" do
    assert_no_difference 'User.count' do
      delete admin_user_path(@other)
    end
    assert_equal "your access is not right, Please log in!", flash[:danger]
    assert_response :redirect
  end
  

  # before_action :admin_user?
  test "non admin user does not access admin/users#index" do
    log_in_as_test_user(@other)
    get admin_users_path
    assert_equal "this access is invalid.", flash[:danger]
    assert_response :redirect
  end

  test "non admin user does not access admin/users#destroy" do
    log_in_as_test_user(@other)
    assert_no_difference 'User.count' do
      delete admin_user_path(@user)
    end
    assert_equal "this access is invalid.", flash[:danger]
    assert_response :redirect
  end
end
