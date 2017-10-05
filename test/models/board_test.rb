require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  def setup
    @b = Board.new(trello_id: "test", project_id: 1)
  end

  test "creates a Board object on .new" do
    assert_instance_of Board, @b, "Object was not a Board"
  end

  test "Board has a .trello_id" do
    assert_respond_to @b, :trello_id, "Board has no trello_id"
  end

  test "Board has a project_id" do
    assert_respond_to @b, :project_id, "Board has no project_id"
  end

  test "Board has a name" do
    assert_respond_to @b, :name, "Board has no .name"
  end

  test "Board validates project_id presence before save" do
    @b.project_id = nil
    refute @b.save, "Board saved without project_id"
  end

  test "Board validates trello_id presence before save" do
    @b.trello_id = nil
    refute @b.save, "Board saved without trello_id"
  end

end
