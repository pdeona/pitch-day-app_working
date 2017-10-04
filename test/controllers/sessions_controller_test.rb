require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @u = users(:one)
  end

  test "it creates a session when provided an existing user" do
    post '/login', params: {trello_id: @u.trello_id}
    assert_equal @u.id, session[:user_id]
  end

end
