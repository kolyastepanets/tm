class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: [:create, :update]

  def create
    @task = @project.tasks.create(task_params)

    unless @task.save
      redirect_to root_path
      flash[:notice] = 'Task can not be blank.'
    end
  end

  # def update
  #   @task = Task.find(params[:id])
  #   if @task.update_attributes(task_params)
  #     redirect_to root_path
  #   else
  #     flash[:notice] = "try again"
  #   end
  # end

  private

    def load_project
      @project = Project.find(params[:project_id])
    end

    def task_params
      params.require(:task).permit(:name, :project_id, :status)
    end
end
