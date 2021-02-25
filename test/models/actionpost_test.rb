require 'test_helper'

class ActionpostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:satoshi)
    @actionpost = @user.actionposts.build(title: "actionpost", highlight: "actionpost", action: "actionpost")
  end

  # テスト用ポストが通るかチェック
  test "should be valid" do
    assert @actionpost.valid?
  end

  # titleのバリデーションチェック
  # 存在性
  test "title should be present" do
    @actionpost.title = "      "
    assert_not @actionpost.valid?
  end

  # highlightのバリデーションチェック
  # 存在性
  test "highlight should be present" do
    @actionpost.highlight = "      "
    assert_not @actionpost.valid?
  end

  # actionのバリデーションチェック
  # 存在性
  test "action should be present" do
    @actionpost.action = "      "
    assert_not @actionpost.valid?
  end

  # 外部キーuser_idのバリデーションチェック
  # 存在性
  test "user_id should be present" do
    @actionpost.user_id = nil
    assert_not @actionpost.valid?
  end  

end