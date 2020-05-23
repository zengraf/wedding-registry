require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    get root_url
    @user = users(:pawel)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should be no session by default" do
    get orders_url
    assert_redirected_to login_url
  end

  test "should be no session after log-out" do
    log_in(@user)
    log_out
    get orders_url
    assert_redirected_to login_url
  end
end
