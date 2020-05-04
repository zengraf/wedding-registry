require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:pawel)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "surname should be present" do
    @user.surname = "  "
    assert_not @user.valid?
  end

  test "phone number should be present" do
    @user.phone_number = "  "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate = @user.dup
    duplicate.email = @user.email.upcase
    @user.save
    assert_not duplicate.valid?
  end

  test "email should be saved in lowercase" do
    mixed_case_email = "AsDf@eXaMpLe.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "        "
    assert_not @user.valid?
  end

  test "password should have at least 8 symbols" do
    @user.password = @user.password_confirmation = "asdfasd"
    assert_not @user.valid?
  end

  test "password and password_confirmation should match" do
    @user.password = "qwerty123"
    @user.password_confirmation = "asdfasdf"
    assert_not @user.valid?
  end
end
