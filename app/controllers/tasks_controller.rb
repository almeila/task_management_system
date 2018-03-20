class TasksController < ApplicationController

  before_action :load_task, only: [:edit, :destroy, :update]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = t('controller.tasks.create_message', title: @task.title)
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = t('controller.tasks.update_message', title: @task.title)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = t('controller.tasks.destroy_message')
    redirect_to action: 'index'
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :end_period)
    end

    def load_task
      @task = Task.find(params[:id])
    end  
end
