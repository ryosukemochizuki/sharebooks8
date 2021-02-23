module SessionsHelper

  # ログイン関連ヘルパーメソッド

    # ログイン状態を保持するためにuser.idをクッキーのセッションに保存するメソッド
    def user_log_in(user)
      session[:user_id] = user.id
    end

    # クッキーのセッションのuser_idを元にログインしているユーザーをcurrent_userとして呼び出せるようにする。
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

  # sessionに入れること・current_userを作ることをまとめたメソッド
  def log_in(user)
    user_log_in(user)
    current_user
  end

  # ユーザーがログインしているかどうかを判断する　viewで使用?
  def user_logged_in?
    !current_user.nil?
  end

  # ログアウト関連ヘルパーメソッド
  
  # 保持しておいたsession情報を破棄する
  def log_out
    session.delete(:user_id)
  end

end
