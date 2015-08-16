class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: [:edit, :update, :destroy]

  respond_to :json, only: :update
  respond_to :js, only: [:create, :destroy]

  def index
    @projects = current_user.projects
    @project = Project.new
  end

  def create
    respond_with(@project = Project.create(project_params.merge(user: current_user)))
  end

  def update
    @project.update(project_params)
    @project.user = current_user
    respond_with @project
  end

  def destroy
    respond_with(@project.destroy)
  end

  private

    def load_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end
end
