class TasksController < ApplicationController

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
      redirect_to action: 'index', info: "登録しました"
    else
      render 'new'
    end
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :end_period)
    end  
end
