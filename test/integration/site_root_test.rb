require 'test_helper'

class SiteRootTest < ActionDispatch::IntegrationTest
  
  test "root_path links" do
    get root_path
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
  end
end
