class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_project, only: [:create, :update]
  before_action :load_task, only: [:update, :destroy, :move_up, :move_down]

  respond_to :js, only: [:create, :destroy]
  respond_to :json, only: :update

  def create
    respond_with(@task = @project.tasks.create(task_params))
  end

  def update
    respond_with(@task.update_attributes(task_params))
  end

  def destroy
    respond_with(@task.destroy)
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.where(id: id).update_all({position: index+1})
    end
    render nothing: true
  end

  def move_up
    @task.move_higher
    redirect_to root_path
  end

  def move_down
    @task.move_lower
    redirect_to root_path
  end

  private

    def load_task
      @task = Task.find(params[:id])
    end

    def load_project
      @project = Project.find(params[:project_id])
    end

    def task_params
      params.require(:task).permit(:name, :project_id, :status)
    end
end
