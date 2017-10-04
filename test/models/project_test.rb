require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @p = Project.new
  end

  test "it creates a Project on .new" do
    assert_instance_of Project, Project.new, "Object created was not a Project"
  end
end
