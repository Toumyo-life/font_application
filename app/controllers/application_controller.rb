class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def not_authenticated
    flash[:warning] = "ログインしてください"
    redirect_to login_path # ここで「login_pathへ行け」と一括指示している
  end
end
