class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(user_id: @current_user.id)
    @project = @current_user.projects.new({ user_id: @current_user.id })
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = @current_user.projects.find(params[:id])
    @project.link_to_trello
  end

  # GET /projects/new
  def new
    @user = User.find_by(id: @current_user.id)
    @project = @user.projects.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    project_params = params[:project]
    @project = Project.new
    @project.create_user_project @current_user, project_params
    respond_to do |format|
      if @project.save
        format.html { redirect_to user_projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :due_by, :repo_id)
    end
end
