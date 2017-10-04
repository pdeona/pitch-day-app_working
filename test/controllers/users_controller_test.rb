require 'test_helper'
require 'capybara/rails'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should get show" do
    @u = users(:one)
    post '/login', params: { trello_id: @u.trello_id }
    get user_url(@u)
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should post create" do
    post users_url, params: { user: { trello_id: "test", slack_id: "test" } }
    assert_response :success
  end

  test "should get destroy" do
    delete user_url(users(:one))
    assert_response :success
  end

end
