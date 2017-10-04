require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @u = users(:one)
  end

  test "it creates a session when provided an existing user" do
    @u.trello_id = "test"
    post '/login', params: { session: {trello_id: "test"} }
    assert_response :success
  end

end
