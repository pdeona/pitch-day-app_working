require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @p = Project.new
  end

  test "it creates a Project on .new" do
    assert_instance_of Project, Project.new, "Object created was not a Project"
  end

  test "validates presence of name" do
    refute @p.save, "Project was saved without name"
  end

  test "validates presence of Due_by" do
    refute @p.save, "Project was saved without due_by"
  end

  test "belongs to one user at .user_id" do
    @p.user_id = User.first.id
    assert_instance_of User, User.find(@p.user_id)
  end

  test "has an array of users as .collaborators" do
    @p.collaborators = User.all
    assert_respond_to  @p, :collaborators, "collaborators did not return an Array"
    @p.collaborators.each do |user|
      assert_instance_of User, user, "collaborator #{user.id} was not a user"
    end
  end

  test "has a github_repo column" do
    assert_respond_to @p, :github_repo, "project does not have a github_repo reader method"
    assert_respond_to @p, :github_repo=, "project does not have a github_repo writer method"
  end

end
