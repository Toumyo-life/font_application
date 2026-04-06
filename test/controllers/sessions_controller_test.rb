require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should post create" do
    # フィクスチャのユーザーでログインを試みる
    post login_path, params: { 
      email: users(:one).email, 
      password: 'password'  # フィクスチャで設定したパスワード
    }
    assert_response :redirect
    assert_redirected_to root_path  # ログイン後のリダイレクト先を確認
  end

  test "should delete destroy" do
    # まずログインしてからログアウトする
    post login_path, params: { 
      email: users(:one).email, 
      password: 'password' 
    }
    
    delete logout_path
    assert_response :redirect
    assert_redirected_to root_path  # ログアウト後のリダイレクト先を確認
  end
end