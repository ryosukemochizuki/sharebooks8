class User < ApplicationRecord
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
                       
  private

  def downcase_email
    self.email = self.email.downcase
  end

end
