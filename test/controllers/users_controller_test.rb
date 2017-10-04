require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_url(users(:one))
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get create" do
    post users_url
    assert_response :success
  end

  test "should get destroy" do
    delete user_url(users(:one))
    assert_response :success
  end

end
