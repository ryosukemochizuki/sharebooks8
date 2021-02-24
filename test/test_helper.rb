ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


class ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  # user_logged_in?を再現
  def is_logged_in?
    !session[:user_id].nil?
  end

  # ログイン過程をまとめておく
  def log_in_as_test_user(user, password: "password", remember_me: '1')
    get login_path
    post login_path, params: {session: {account_id: user.account_id, 
                                       password: password, 
                                       remember_me: remember_me}}
  end

end