require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:satoshi)
  end

  # テストユーザーが正しいかチェック
  test "@user should be valid" do
    assert @user.valid?
  end

  # account_idのvalidationチェック
  # 存在性
  test "account_id should be present" do
    @user.account_id = "      "
    assert_not @user.valid?
  end
  # 長さ
  test "account_id should have maximum length 50word" do
    @user.account_id = "a" * 51
    assert_not @user.valid?
  end
  # フォーマット
  test "account_id is not registered with invalid format" do
    invalid_account_ids = %w[user123 .user123 @user@123]
    invalid_account_ids.each do |invalid_account_id|
      @user.account_id = invalid_account_id
      assert_not @user.valid?, "#{invalid_account_id.inspect} should be invalid"
    end
  end

  test "account_id is registered with valid format" do
    valid_account_ids = %w[@user123 @USER123 @.user123 @user.123 @user_123]
    valid_account_ids.each do |valid_account_id|
      @user.account_id = valid_account_id
      assert @user.valid?, "#{valid_account_id.inspect} should be valid"
    end
  end
  # 一意性
  test "account_id should be unique" do
    duplicated_user = @user.dup
    @user.save
    assert_not duplicated_user.valid?
    # @user.save
    # @duplicated_user.account_id = @user.account_id
    # @duplicated_user.save
    # assert_not @duplicated_user.valid?
  end

  # usernameのvalidationチェック
  # 存在性
  test "username should be present" do
    @user.username = "      "
    assert_not @user.valid?
  end
  # 長さ
  test "username should have maximum length 50word" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  # emailのvalidationチェック
  # 存在性
  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end
  # 長さ
  test "email should have maximum length 200" do
    @user.email = "a" * 189 + "@example.com" 
    assert_not @user.valid?
  end
  # フォーマット
  test "email should not be registered with invalid format" do
    invalid_emails = %w[@user@example.com user@@example.com user@example@com user.example.com user.example]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "email should be registered with valid format" do
    valid_emails = %w[user@example.com USER@EXAMPLE.ORG user_12@rails.jp]
    valid_emails.each do |valid_email|
      @user.email = valid_email.downcase
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end
  # 一意性
  test "email should be unique" do
    duplicated_user = @user.dup
    @user.save
    assert_not duplicated_user.valid?
  end

  # has_secure_passwordのvalidationチェック
  # 存在性
  test "password should be present" do
    @user.password = @user.password_confirmation = "      "
    assert_not @user.valid?
  end
  # 長さ
  test "password should have minimum length 6word" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  # フォーマット
  test "password should not be registered with invalid password" do
    invalid_passwords = %w[password PASSWORD 12345678 Password password1 PASSWORD1]
    invalid_passwords.each do |invalid_password|
      @user.password = @user.password_confirmation = invalid_password
      assert_not @user.valid?, "#{invalid_password.inspect} should be invalid"
    end
  end

  test "password should be registered with valid password" do
    valid_passwords = %w[Password1 passWord1 passworD1 1passworD]
    valid_passwords.each do |valid_password|
      @user.password = @user.password_confirmation = valid_password
      assert @user.valid?, "#{valid_password.inspect} should be valid"
    end
  end


  # authenticate?実行時remember_digestがnilだった時にfalseを返すか(２つの異なるブラウザ間でのバグを拾う)
  # satoshiはpassword_digestを設定していないのでnilになる
  test "should return false when login with remember_digest nil" do
    assert_not @user.authenticate?(:remember, "")
  end

end
