require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post users_path, params: { 
        user: { 
          first_name: "太郎",
          last_name: "山田",
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        } 
      }
    end
    assert_response :redirect
    assert_redirected_to login_path
  end
end
