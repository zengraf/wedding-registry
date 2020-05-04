require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @archived = orders(:archived)
    @upcoming = orders(:upcoming)
    @admin = users(:daria)
    @non_admin = users(:pawel)
  end

  test "should redirect index when not logged in" do
    get orders_index_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect archive when not logged in" do
    get orders_archive_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get orders_new_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Orders.count' do
      get orders_create_url, params: { order: { name: "Karolina", surname: "Nowak", phone_number: "+48264836475", date: "2020-11-23", deposit: 2000, hall_id: 1, confirmed: true, added_by: users(:pawel) }}
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get orders_edit_url(@archived)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch orders_url(@archived), params: { order: { deposit: @archived.deposit + 2000 }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Orders.count' do
      delete orders_url(@archived)
    end
    assert_redirected_to login_url
  end

  test "non-admin should not change order's confirmed parameter" do
    log_in(@non_admin)
    assert_not @non_admin.role.admin?
    patch order_url(@upcoming), params: { order: { confirmed: FILL_IN } }
    assert_not @upcoming.FILL_IN.confirmed?
  end

  test "non-admin should not change confirmed order's parameters" do
    log_in(@non_admin)
    assert_not @non_admin.role.admin?
    old_deposit = @upcoming.deposit
    patch order_url(@upcoming), params: { order: { deposit: @upcoming + 2000 } }
    assert_equal old_deposit, @upcoming.deposit
  end

  test "non-admin should not delete orders" do
    log_in(@non_admin)
    assert_no_difference 'Orders.count' do
      delete orders_url(@upcoming)
    end
  end
  
end
