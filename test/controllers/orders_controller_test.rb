require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @confirmed = orders(:archived)
    @not_confirmed = orders(:upcoming)
    @admin = users(:daria)
    @admin.password = "qwertyasdf1234"
    @non_admin = users(:pawel)
    @non_admin.password = "bartoszKool1357"
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
    get edit_order_url(@confirmed)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch order_url(@confirmed), params: { order: { deposit: @confirmed.deposit + 2000 }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Order.count' do
      delete order_url(@confirmed)
    end
    assert_redirected_to login_url
  end

  test "non-admin should not change order's confirmed parameter" do
    log_in(@non_admin)
    assert_not @non_admin.admin?
    assert @confirmed.confirmed?
    patch order_url(@not_confirmed), params: { order: { confirmed: true } }
    assert_not @not_confirmed.reload.confirmed?
  end

  test "non-admin should not change confirmed order's parameters" do
    log_in(@non_admin)
    assert_not @non_admin.admin?
    assert @confirmed.confirmed?
    old_deposit = @confirmed.deposit
    patch order_url(@confirmed), params: { order: { deposit: old_deposit + 2000 } }
    assert_equal old_deposit, @confirmed.reload.deposit
  end

  test "non-admin should not delete confirmed orders" do
    log_in(@non_admin)
    assert_not @non_admin.admin?
    assert @confirmed.confirmed?
    assert_no_difference 'Order.count' do
      delete order_url(@confirmed)
    end
  end
  
  test "admin is able to change order's confirmed parameter" do
    log_in(@admin)
    assert @admin.admin?
    assert @confirmed.confirmed?
    patch order_url(@confirmed), params: { order: { confirmed: true } }
    assert @confirmed.reload.confirmed?
  end

  test "admin is able to change confirmed order's parameters" do
    log_in(@admin)
    assert @admin.admin?
    assert @confirmed.confirmed?
    old_deposit = @confirmed.deposit
    patch order_url(@confirmed), params: { order: { deposit: old_deposit + 2000 } }
    assert_not_equal old_deposit, @confirmed.reload.deposit
  end

  test "admin is able to delete confirmed orders" do
    log_in(@admin)
    assert @admin.admin?
    assert @confirmed.confirmed?
    assert_difference "Order.count", -1 do
      delete order_url(@confirmed)
    end
  end

  test "new order should not be confirmed by default" do
    log_in(@admin)
    post orders_url, params: { order: { name: "Karolina", surname: "Nowak", phone_number: "+48264836475", date: "2020-11-23", deposit: 2000, hall_id: 1 } }
    assert_not Order.order(created_at: :asc).last.confirmed?
  end

  test "non-admin should not create confirmed order" do
    log_in(@non_admin)
    assert_not @non_admin.admin?
    post orders_url, params: { order: { name: "Karolina", surname: "Nowak", phone_number: "+48264836475", date: "2020-11-23", deposit: 2000, hall_id: 1, confirmed: true } }
    assert_not Order.order(created_at: :asc).last.confirmed?
  end
end
