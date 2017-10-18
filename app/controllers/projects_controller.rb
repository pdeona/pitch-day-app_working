class ProjectsController < ApplicationController
  self.per_form_csrf_tokens = true
  before_action :set_project, only: [:show, :edit, :update, :destroy, :new_collaborators, :add_collaborators, :add_repo]
  before_action :current_user
  before_action :require_login
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(user_id: @current_user.id)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    board = @project.board
    unless @project.repo.nil?
      if (@project.repo.langs.nil? || @project.repo.updated_at < (Time.new - 12.hours))
        @langs = @project.repo.get_languages @current_user
      else
        @langs = @project.repo.langs
      end
    end
    if (!(board.nil?) || board.card_status == ("{\"blocked\":[{\"unassigned\":[],\"working\":[]}],\"inpr\":[{\"unassigned\":[],\"working\":[]}]}") || board.card_status.nil? )
      if (board.updated_at < Time.new - 1.hour)
        lists = ['Blocked', 'In Progress']
        @cards_status = {blocked: [], inpr: []}
        lists.each do |list|
          if list == 'Blocked'
            @cards_status[:blocked] << board.check_card_status(@current_user, list)
          else
            @cards_status[:inpr] << board.check_card_status(@current_user, list)
          end
        end
        board.card_status = (@cards_status).to_json
        board.save! unless @cards_status.nil?
      else
        @cards_status = board.card_status ? JSON.parse(board.card_status) : {blocked: [], inpr: []}
      end
    else
      @cards_status = 'Creating your Trello Board...'
    end
    render partial: 'dashboard_show', project: @project, langs: @langs, cards: @cards_status
  end

  # GET /projects/new
  def new
    @user = User.find_by(id: @current_user.id)
    @project = @user.projects.new
    respond_to do |f|
      f.js { render partial: 'dashboard_new', project: @project }
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new.new_project_steps @current_user, project_params
    respond_to do |format|
      if @project.save
        @current_user.projects << @project
        @current_user.save
        format.html { redirect_to root_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render partial: 'form' }
        format.js { render partial: 'dashboard_new' }
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
      format.html { redirect_to root_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_collaborators
    @project = Project.find params[:id]
    render partial: 'modal_collabs', project: @project
  end

  def add_collaborators
    @users = params[:data].split(',').map(&:strip)
    users = []
    @users.each do |user|
      users << User.find_by(trello_id: user)
    end
    @langs = @project.repo.nil? ? nil : @project.repo.langs
    @project.add_collaborators @current_user, users
    respond_to do |f|
      # f.html { redirect_to user_path(@current_user), notice: 'Collaborators added!' }
      f.js { render partial: 'dashboard_show', project: @project, cards: @project.board.card_status, langs: @langs, notice: 'Collaborators added!'}
    end
  end

  def add_repo
    repo_name = params[add_repo_path(@project)][:repo_name]
    @project.repo = Repo.link_existing_repo @current_user, @project, repo_name
    if @project.save
      @langs = @project.repo.get_languages @current_user
      render partial: 'dashboard_show', project: @project, cards: @project.board.card_status, langs: @langs, notice: 'Repo linked!'
    else
      render partial: 'add_repo'
    end
  end

  def board_details
    @cards_status = @project.board.check_cards_job @current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :due_by, :repo_name, :user_id, :trello_board?, :trello_name)
    end
end
