require 'test_helper'

class PaginationTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:satoshi)
  end

  test "actionposts/index pagination" do
    log_in_as_test_user(@user)
    get actionposts_path
    assert_select 'title', full_title("All actions")
    assert_select 'ul.pagination'
  end

  test "users/show pagination" do
    log_in_as_test_user(@user)
    get user_path(@user)
    assert_select 'title', full_title(@user.account_id)
    assert_select 'ul.pagination'
  end
end
