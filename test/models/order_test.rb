require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:upcoming)
  end

  test "name should be present" do
    @order.name = "  "
    assert_not @order.valid?
  end

  test "surname should be present" do
    @order.surname = "  "
    assert_not @order.valid?
  end

  test "phone number should be present" do
    @order.phone_number = "  "
    assert_not @order.valid?
  end

  test "date should be present" do
    @order.date = nil
    assert_not @order.valid?
  end

  test "deposit should not be less than 0" do
    @order.deposit = -1
    assert_not @order.valid?
  end
end
