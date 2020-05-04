require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:pawel)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should be no session by default" do
    assert_not logged_in?
  end

  test "should be no session after log-out" do
    log_in(@user)
    log_out
    assert_not logged_in?
  end

  test "should be correct current user" do
    log_in(@user)
    assert_equal @user, current_user
end
