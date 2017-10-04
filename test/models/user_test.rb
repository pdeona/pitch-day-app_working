require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @u = users(:one)
  end

  test "it creates an instance of User on .new" do
    assert_instance_of User, (User.new), "Object created was not a User."
  end

  test "it has a .trello_id attribute reader" do
    assert_respond_to @u, :trello_id, "User has no .trello_id reader method"
  end

  test "it has a .trello_id= attribute writer" do
    assert_respond_to @u, :trello_id=, "User has no .trello_id writer methood"
  end

  test "it validates .trello_id presence before storing User data" do
    @u.trello_id = nil
    refute @u.save, "User does not validate presence of trello_id before saving"
  end

  test "it validates .trello_id uniqueness before storing User data" do
    @u.trello_id = "test"
    @u.save
    other_u = User.new
    other_u.trello_id = "test"
    refute other_u.save, "User does not validate trello_id uniqueness before save"
  end

end
