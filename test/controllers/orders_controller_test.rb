require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @archived = orders(:archived)
    @upcoming = orders(:upcoming)
    @admin = users(:daria)
    @non_admin = users(:pawel)
  end

  test "should redirect index when not logged in" do
    get orders_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect archive when not logged in" do
    get archive_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get new_order_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Order.count' do
      post orders_url, params: { order: { name: "Karolina", surname: "Nowak", phone_number: "+48264836475", date: "2020-11-23", deposit: 2000, hall_id: 1, confirmed: true, added_by: @non_admin }}
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_order_url(@archived)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch order_url(@archived), params: { order: { deposit: @archived.deposit + 2000 }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Order.count' do
      delete order_url(@archived)
    end
    assert_redirected_to login_url
  end

  test "non-admin should not change order's confirmed parameter" do
    log_in(@non_admin)
    assert_not @non_admin.admin?
    patch order_url(@upcoming), params: { order: { confirmed: true } }
    assert_not @upcoming.confirmed?
  end

  test "non-admin should not change confirmed order's parameters" do
    log_in(@non_admin)
    assert_not @non_admin.admin?
    old_deposit = @upcoming.deposit
    patch order_url(@upcoming), params: { order: { deposit: @upcoming.deposit + 2000 } }
    assert_equal old_deposit, @upcoming.deposit
  end

  test "non-admin should not delete orders" do
    log_in(@non_admin)
    assert_no_difference 'Order.count' do
      delete order_url(@upcoming)
    end
  end
  
end
