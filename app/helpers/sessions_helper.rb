module SessionsHelper

  # ログイン関連ヘルパーメソッド

    # ログイン状態を保持するためにuser.idを一時セッションに保存するメソッド
    def user_log_in(user)
      session[:user_id] = user.id
    end

    # remember_digestの保存とremember_token・user_idを永続セッションとして保存するメソッド
    def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      # rememberインスタンスメソッドを呼び出した時はtokenが存在している
      cookies.permanent[:remember_token] = user.remember_token
    end

    # user_idを元にログインしているユーザーをcurrent_userとして呼び出せるようにする。
    def current_user
      if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
        user ||= User.find_by(id: user_id)
        if user && user.authenticate?("remember", cookies[:remember_token])
          log_in(user)
          @current_user = user
        end
      else
      end
    end

  # 一時sessionに入れること・永続sessionを入れること・current_userを作ることをまとめたメソッド
  def log_in(user)
    user_log_in(user)
    current_user
  end

  # ユーザーがログインしているかどうかを判断する　viewで使用?
  def user_logged_in?
    !current_user.nil?
  end

  # ログアウト関連ヘルパーメソッド

    # remember_digestの破棄とremember_token・user_idを削除するメソッド
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
  
  # 保持しておいたsession情報を破棄する
  def log_out(user)
    forget(user)
    session.delete(:user_id)
  end

end
