require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    andrew = users(:one)
    post :create, name: 'andrew', password: 'secret'
    assert_redirected_to admin_url
    assert_equal andrew.id, session[:user_id]
  end

  test "should fail login" do
    andrew = users(:one)
    post :create, name: andrew.name, password: 'wrong'
    assert_redirected_to login_url
  end

  test "should get destroy" do
    get :destroy
    assert_redirected_to store_url
  end

end
