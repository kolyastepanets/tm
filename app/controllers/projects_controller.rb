class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: [:edit, :update, :destroy]

  def index
    @projects = current_user.projects
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to root_path
      flash[:notice] = 'Your project successfully created.'
    else
      redirect_to root_path
      flash[:notice] = 'Project can not be blank.'
    end
  end

  def update
    @project.update(project_params)
    @project.user = current_user
  end

  def destroy
    @project.destroy
    redirect_to projects_path
    flash[:notice] = "Your project successfully deleted."
  end

  private

    def load_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end
end
