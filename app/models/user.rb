class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email

  VALID_ACCOUNT_ID_FORMAT = /\A@[\w\-.]+\z/
  validates :account_id, presence: true, 
                         length: {maximum: 50},
                         format: VALID_ACCOUNT_ID_FORMAT, 
                         uniqueness: {case_sensitive: true}
  
  validates :username, presence: true, 
                       length: {maximum: 50}

  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[\w\-.]+\.[a-z]+\z/
  validates :email, presence: true, 
                    length: {maximum: 200}, 
                    format: VALID_EMAIL_FORMAT, 
                    uniqueness: {case_sensitive: false}

  has_secure_password
  VALID_PASSWORD_FORMAT = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/
  validates :password, presence: true, 
                       length: {minimum: 6}, 
                       format: VALID_PASSWORD_FORMAT, 
                       allow_nil: true
                       

  # 受け取った文字列をハッシュ化するクラスメソッド(最初はテストのために生成→再利用)
  def self.digest(string)
    # ActiveModel on githubより
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 新しいトークンを作成するクラスメソッド
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # remember_digestに生成したトークンをハッシュ化させた値を代入するインスタンスメソッド
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # データベースにあるdigestとtokenを比較するインスタンスメソッド
  def authenticate?(attribute, attribute_token)
    attribute_digest = send("#{attribute}_digest")
    return false if attribute_digest.nil?
    BCrypt::Password.new(attribute_digest).is_password?(attribute_token)
  end

  # 永続セッションを破棄するインスタンスメソッド
  def forget
    update_attribute(:remember_digest, nil)
  end  

  private

  def downcase_email
    self.email = self.email.downcase
  end

end
